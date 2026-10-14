import 'voice_bridge_stub.dart'
    if (dart.library.js_interop) 'voice_bridge_web.dart' as impl;

/// Joins and leaves Anna's voice call. Events arrive as decoded JSON maps:
/// `transcript`, `level`, `agent`, `connection`, `state` and `error`.
abstract final class VoiceBridge {
  static bool get isSupported => impl.isSupported;

  static Future<void> start({
    required String appId,
    required String channel,
    required String token,
    required String uid,
    required void Function(Map<String, dynamic> event) onEvent,
  }) =>
      impl.start(appId, channel, token, uid, onEvent);

  static Future<void> stop() => impl.stop();

  static Future<void> setMuted(bool muted) => impl.setMuted(muted);

  static Future<void> renewToken(String token) => impl.renewToken(token);
}
