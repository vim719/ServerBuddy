const isSupported = false;

Future<void> start(
  String appId,
  String channel,
  String token,
  String uid,
  void Function(Map<String, dynamic> event) onEvent,
) =>
    throw UnsupportedError('Voice calls are available in the web app.');

Future<void> stop() async {}

Future<void> setMuted(bool muted) async {}

Future<void> renewToken(String token) async {}
