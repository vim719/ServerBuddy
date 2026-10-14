import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Builds Agora AccessToken2 tokens ("007..."), the same format as Agora's
/// official token builder used by the Conversational AI SDK.
class AgoraToken {
  static const credentialLength = 32;

  /// A combined RTC + RTM token for [uid] in [channelName]. Used both by the
  /// app to join the call and as `Authorization: agora token=<token>` for the
  /// Conversational AI REST API.
  static String convoAiToken({
    required String appId,
    required String appCertificate,
    required String channelName,
    required int uid,
    int tokenExpire = 86400,
    int privilegeExpire = 0,
    int? issueTs,
    int? salt,
  }) {
    _requireValidCredentials(appId, appCertificate);
    final privExpire = privilegeExpire != 0 ? privilegeExpire : tokenExpire;
    final account = '$uid';

    final rtc = _packServiceRtc(channelName, account, {
      1: privExpire, // join channel
      2: privExpire, // publish audio
      3: privExpire, // publish video
      4: privExpire, // publish data stream
    });
    final rtm = _packServiceRtm(account, {1: tokenExpire}); // login

    return _buildAccessToken2(
      appId: appId,
      appCertificate: appCertificate,
      expire: tokenExpire,
      services: [rtc, rtm],
      issueTs: issueTs,
      salt: salt,
    );
  }

  static void _requireValidCredentials(String appId, String appCertificate) {
    if (appId.length != credentialLength ||
        appCertificate.length != credentialLength) {
      throw ArgumentError(
        'agoraAppId and agoraAppCertificate must each be exactly '
        '$credentialLength characters (got ${appId.length} and '
        '${appCertificate.length}).',
      );
    }
  }

  static String _buildAccessToken2({
    required String appId,
    required String appCertificate,
    required int expire,
    required List<Uint8List> services,
    int? issueTs,
    int? salt,
  }) {
    final ts = issueTs ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final s = salt ?? Random.secure().nextInt(99999999) + 1;

    var signing =
        Hmac(sha256, _uint32(ts)).convert(utf8.encode(appCertificate)).bytes;
    signing = Hmac(sha256, _uint32(s)).convert(signing).bytes;

    final info = BytesBuilder()
      ..add(_string(utf8.encode(appId)))
      ..add(_uint32(ts))
      ..add(_uint32(expire))
      ..add(_uint32(s))
      ..add(_uint16(services.length));
    for (final svc in services) {
      info.add(svc);
    }
    final signingInfo = info.toBytes();

    final signature = Hmac(sha256, signing).convert(signingInfo).bytes;
    final payload = BytesBuilder()
      ..add(_string(signature))
      ..add(signingInfo);
    final compressed = ZLibCodec().encode(payload.toBytes());
    return '007${base64.encode(compressed)}';
  }

  static Uint8List _packServiceRtc(
    String channelName,
    String account,
    Map<int, int> privileges,
  ) {
    return (BytesBuilder()
          ..add(_uint16(1))
          ..add(_mapUint32(privileges))
          ..add(_string(utf8.encode(channelName)))
          ..add(_string(utf8.encode(account))))
        .toBytes();
  }

  static Uint8List _packServiceRtm(String userId, Map<int, int> privileges) {
    return (BytesBuilder()
          ..add(_uint16(2))
          ..add(_mapUint32(privileges))
          ..add(_string(utf8.encode(userId))))
        .toBytes();
  }

  static Uint8List _uint16(int v) =>
      (ByteData(2)..setUint16(0, v, Endian.little)).buffer.asUint8List();

  static Uint8List _uint32(int v) =>
      (ByteData(4)..setUint32(0, v, Endian.little)).buffer.asUint8List();

  static Uint8List _string(List<int> bytes) => (BytesBuilder()
        ..add(_uint16(bytes.length))
        ..add(bytes))
      .toBytes();

  static Uint8List _mapUint32(Map<int, int> m) {
    final b = BytesBuilder()..add(_uint16(m.length));
    for (final k in m.keys.toList()..sort()) {
      b
        ..add(_uint16(k))
        ..add(_uint32(m[k]!));
    }
    return b.toBytes();
  }
}
