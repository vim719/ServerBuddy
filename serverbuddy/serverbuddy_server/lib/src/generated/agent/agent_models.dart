/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// Connection details the app needs to join a voice call with Anna.
abstract class VoiceConfig
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VoiceConfig._({
    required this.appId,
    required this.token,
    required this.uid,
    required this.channelName,
    required this.agentUid,
  });

  factory VoiceConfig({
    required String appId,
    required String token,
    required String uid,
    required String channelName,
    required String agentUid,
  }) = _VoiceConfigImpl;

  factory VoiceConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceConfig(
      appId: jsonSerialization['appId'] as String,
      token: jsonSerialization['token'] as String,
      uid: jsonSerialization['uid'] as String,
      channelName: jsonSerialization['channelName'] as String,
      agentUid: jsonSerialization['agentUid'] as String,
    );
  }

  /// Agora App ID
  String appId;

  /// RTC + RTM token for the user
  String token;

  /// The user's numeric RTC uid, as a string
  String uid;

  /// The channel to join
  String channelName;

  /// The numeric RTC uid Anna will join with, as a string
  String agentUid;

  /// Returns a shallow copy of this [VoiceConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VoiceConfig copyWith({
    String? appId,
    String? token,
    String? uid,
    String? channelName,
    String? agentUid,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceConfig',
      'appId': appId,
      'token': token,
      'uid': uid,
      'channelName': channelName,
      'agentUid': agentUid,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceConfig',
      'appId': appId,
      'token': token,
      'uid': uid,
      'channelName': channelName,
      'agentUid': agentUid,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _VoiceConfigImpl extends VoiceConfig {
  _VoiceConfigImpl({
    required String appId,
    required String token,
    required String uid,
    required String channelName,
    required String agentUid,
  }) : super._(
         appId: appId,
         token: token,
         uid: uid,
         channelName: channelName,
         agentUid: agentUid,
       );

  /// Returns a shallow copy of this [VoiceConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VoiceConfig copyWith({
    String? appId,
    String? token,
    String? uid,
    String? channelName,
    String? agentUid,
  }) {
    return VoiceConfig(
      appId: appId ?? this.appId,
      token: token ?? this.token,
      uid: uid ?? this.uid,
      channelName: channelName ?? this.channelName,
      agentUid: agentUid ?? this.agentUid,
    );
  }
}
