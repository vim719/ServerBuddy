// Thin browser bridge between the Flutter app and Agora's Web SDKs.
// Flutter calls window.annaVoice.start/stop/setMuted; events come back as
// JSON strings through the onEvent callback.
(function () {
  let rtc = null;
  let rtm = null;
  let mic = null;
  let agentTrack = null;
  let levelTimer = null;
  let emit = () => {};

  const send = (event) => {
    try {
      emit(JSON.stringify(event));
    } catch (e) {
      console.error('annaVoice emit failed', e);
    }
  };

  const parseMessage = (raw) => {
    try {
      const text = typeof raw === 'string' ? raw : new TextDecoder().decode(raw);
      return JSON.parse(text);
    } catch (_) {
      return null;
    }
  };

  async function start(appId, channel, token, uid, onEvent) {
    emit = onEvent;
    AgoraRTC.setLogLevel(3);

    rtc = AgoraRTC.createClient({ mode: 'rtc', codec: 'vp8' });
    rtc.on('user-published', async (user, mediaType) => {
      if (mediaType !== 'audio') return;
      await rtc.subscribe(user, mediaType);
      agentTrack = user.audioTrack;
      agentTrack.play();
      send({ type: 'agent', state: 'joined' });
    });
    rtc.on('user-unpublished', (_user, mediaType) => {
      if (mediaType === 'audio') agentTrack = null;
    });
    rtc.on('user-left', () => {
      agentTrack = null;
      send({ type: 'agent', state: 'left' });
    });
    rtc.on('connection-state-change', (state) => send({ type: 'connection', state }));

    await rtc.join(appId, channel, token, Number(uid));
    mic = await AgoraRTC.createMicrophoneAudioTrack({
      AEC: true,
      ANS: true,
      AGC: true,
    });
    await rtc.publish([mic]);

    rtm = new AgoraRTM.RTM(appId, String(uid));
    rtm.addEventListener('message', (e) => {
      const msg = parseMessage(e.message);
      if (!msg) return;
      const kind = msg.object || msg.event_type;
      if (kind === 'user.transcription' || kind === 'assistant.transcription') {
        send({
          type: 'transcript',
          role: kind === 'user.transcription' ? 'user' : 'assistant',
          turnId: msg.turn_id ?? 0,
          text: msg.text || '',
          final: msg.final === true || msg.turn_status === 1,
        });
      } else if (kind === 'message.state') {
        send({ type: 'state', state: msg.state || '' });
      } else if (kind === 'message.error') {
        send({ type: 'error', message: msg.message || 'Agent error' });
      }
    });
    await rtm.login({ token });
    await rtm.subscribe(channel);

    levelTimer = setInterval(() => {
      send({
        type: 'level',
        agent: agentTrack ? agentTrack.getVolumeLevel() : 0,
        user: mic && !mic.muted ? mic.getVolumeLevel() : 0,
      });
    }, 120);

    send({ type: 'connection', state: 'CONNECTED' });
  }

  async function stop() {
    clearInterval(levelTimer);
    levelTimer = null;
    try {
      if (mic) {
        mic.stop();
        mic.close();
      }
      if (rtc) await rtc.leave();
      if (rtm) await rtm.logout();
    } catch (e) {
      console.warn('annaVoice stop', e);
    }
    rtc = rtm = mic = agentTrack = null;
  }

  async function setMuted(muted) {
    if (mic) await mic.setMuted(muted);
  }

  async function renewToken(token) {
    if (rtc) await rtc.renewToken(token);
    if (rtm) await rtm.renewToken(token);
  }

  window.annaVoice = { start, stop, setMuted, renewToken };
})();
