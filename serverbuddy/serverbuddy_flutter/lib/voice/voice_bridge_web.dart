import 'dart:convert';
import 'dart:js_interop';

@JS('annaVoice')
external _AnnaVoice? get _annaVoice;

extension type _AnnaVoice(JSObject _) implements JSObject {
  external JSPromise<JSAny?> start(
    JSString appId,
    JSString channel,
    JSString token,
    JSString uid,
    JSFunction onEvent,
  );
  external JSPromise<JSAny?> stop();
  external JSPromise<JSAny?> setMuted(JSBoolean muted);
  external JSPromise<JSAny?> renewToken(JSString token);
}

_AnnaVoice get _voice {
  final voice = _annaVoice;
  if (voice == null) {
    throw StateError('anna_voice.js did not load.');
  }
  return voice;
}

bool get isSupported => _annaVoice != null;

Future<void> start(
  String appId,
  String channel,
  String token,
  String uid,
  void Function(Map<String, dynamic> event) onEvent,
) async {
  void handle(JSString json) {
    onEvent(jsonDecode(json.toDart) as Map<String, dynamic>);
  }

  await _voice
      .start(appId.toJS, channel.toJS, token.toJS, uid.toJS, handle.toJS)
      .toDart;
}

Future<void> stop() async {
  final voice = _annaVoice;
  if (voice != null) await voice.stop().toDart;
}

Future<void> setMuted(bool muted) => _voice.setMuted(muted.toJS).toDart;

Future<void> renewToken(String token) => _voice.renewToken(token.toJS).toDart;
