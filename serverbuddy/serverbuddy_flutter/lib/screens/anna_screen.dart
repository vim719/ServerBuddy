import 'dart:async';

import 'package:flutter/material.dart';
import 'package:serverbuddy_client/serverbuddy_client.dart';

import '../client.dart';
import '../voice/voice_bridge.dart';

/// The ServerBuddy palette, shared with the showcase page.
abstract final class Palette {
  static const red = Color(0xFFFF595E);
  static const yellow = Color(0xFFFFCA3A);
  static const green = Color(0xFF8AC926);
  static const blue = Color(0xFF1982C4);
  static const purple = Color(0xFF6A4C93);
  static const ink = Color(0xFF14161F);
  static const muted = Color(0xFF5B6172);
  static const all = [red, yellow, green, blue, purple];
}

class _Line {
  _Line(this.role, this.turnId, this.text, this.isFinal);
  final String role;
  final int turnId;
  String text;
  bool isFinal;
}

/// Meet Anna: start a voice call, talk, and see the live transcript.
class AnnaScreen extends StatefulWidget {
  const AnnaScreen({super.key});

  @override
  State<AnnaScreen> createState() => _AnnaScreenState();
}

class _AnnaScreenState extends State<AnnaScreen> {
  final _nameController = TextEditingController();
  final _scrollController = ScrollController();
  final _lines = <_Line>[];

  VoiceConfig? _config;
  String? _agentId;
  bool _starting = false;
  bool _inCall = false;
  bool _muted = false;
  bool _agentJoined = false;
  double _agentLevel = 0;
  double _userLevel = 0;
  String? _error;
  Timer? _renewTimer;

  @override
  void dispose() {
    _renewTimer?.cancel();
    if (_inCall) _endCall();
    _nameController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _startCall() async {
    setState(() {
      _starting = true;
      _error = null;
      _lines.clear();
      _agentJoined = false;
    });
    final name = _nameController.text.trim();
    Future<String>? agentStart;
    try {
      final config = await client.agent.getConfig();
      // Start Anna and join the call in parallel, as the original web app did.
      agentStart = client.agent.startAgent(
        config.channelName,
        int.parse(config.agentUid),
        int.parse(config.uid),
        userKey: name.isEmpty ? null : name,
      );
      await VoiceBridge.start(
        appId: config.appId,
        channel: config.channelName,
        token: config.token,
        uid: config.uid,
        onEvent: _onVoiceEvent,
      );
      _config = config;
      _agentId = await agentStart;
      // Tokens last an hour; renew a few minutes before they expire.
      _renewTimer = Timer(const Duration(minutes: 55), _renewToken);
      setState(() {
        _inCall = true;
        _starting = false;
      });
    } catch (e) {
      await VoiceBridge.stop();
      // Don't leave Anna talking to an empty channel.
      final startedId = await agentStart?.then<String?>((id) => id).catchError(
            (Object _) => null,
          );
      if (startedId != null) {
        client.agent.stopAgent(startedId).ignore();
      }
      setState(() {
        _starting = false;
        _error = 'Could not start the conversation. Please allow the '
            'microphone and try again.\n$e';
      });
    }
  }

  Future<void> _renewToken() async {
    final config = _config;
    if (config == null) return;
    final renewed = await client.agent.getConfig(
      channel: config.channelName,
      uid: int.parse(config.uid),
    );
    await VoiceBridge.renewToken(renewed.token);
  }

  Future<void> _endCall() async {
    _renewTimer?.cancel();
    final agentId = _agentId;
    _agentId = null;
    await VoiceBridge.stop();
    if (agentId != null) {
      try {
        await client.agent.stopAgent(agentId);
      } catch (_) {
        // The agent also stops on its own after 30 seconds of idle time.
      }
    }
    if (mounted) {
      setState(() {
        _inCall = false;
        _muted = false;
        _agentLevel = 0;
        _userLevel = 0;
      });
    }
  }

  Future<void> _toggleMute() async {
    await VoiceBridge.setMuted(!_muted);
    setState(() => _muted = !_muted);
  }

  void _onVoiceEvent(Map<String, dynamic> event) {
    if (!mounted) return;
    switch (event['type']) {
      case 'level':
        setState(() {
          _agentLevel = (event['agent'] as num?)?.toDouble() ?? 0;
          _userLevel = (event['user'] as num?)?.toDouble() ?? 0;
        });
      case 'agent':
        setState(() => _agentJoined = event['state'] == 'joined');
      case 'error':
        setState(() => _error = event['message'] as String?);
      case 'transcript':
        _onTranscript(event);
    }
  }

  void _onTranscript(Map<String, dynamic> event) {
    final role = event['role'] as String;
    final turnId = (event['turnId'] as num?)?.toInt() ?? 0;
    final text = (event['text'] as String?) ?? '';
    if (text.trim().isEmpty) return;
    setState(() {
      final existing = _lines
          .where((l) => l.role == role && l.turnId == turnId)
          .firstOrNull;
      if (existing != null) {
        existing
          ..text = text
          ..isFinal = event['final'] == true;
      } else {
        _lines.add(_Line(role, turnId, text, event['final'] == true));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (!_inCall) const _PaletteBars(),
          SafeArea(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: _inCall ? 720 : 440,
                        ),
                        child: _inCall ? _buildCall() : _buildStart(),
                      ),
                    ),
                  ),
                ),
                const _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStart() {
    final theme = Theme.of(context);
    return _Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Meet '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: Palette.all,
                    ).createShader(bounds),
                    child: Text(
                      'Anna',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: Palette.ink,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Anna remembers what you tell her. Share your name so your next '
            'call picks up where this one left off.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: Palette.muted),
          ),
          const SizedBox(height: 24),
          Text(
            'Your name (optional — leave blank to stay anonymous)',
            style: theme.textTheme.labelMedium?.copyWith(color: Palette.ink),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            enabled: !_starting,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _starting ? null : _startCall(),
            decoration: InputDecoration(
              hintText: 'e.g. Alex',
              filled: true,
              fillColor: const Color(0xFFF7F8FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _starting || !VoiceBridge.isSupported ? null : _startCall,
            style: FilledButton.styleFrom(
              backgroundColor: Palette.blue,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(_starting ? 'Connecting…' : 'Start Conversation'),
          ),
          if (!VoiceBridge.isSupported) ...[
            const SizedBox(height: 12),
            Text(
              'Voice calls run in the web app.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: Palette.red),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCall() {
    final theme = Theme.of(context);
    final status = !_agentJoined
        ? 'Anna is joining…'
        : _muted
            ? 'Muted'
            : 'Listening';
    return _Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Palette.purple,
                child: Text('A', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anna',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      status,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Palette.muted,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                tooltip: _muted ? 'Unmute' : 'Mute',
                onPressed: _toggleMute,
                icon: Icon(_muted ? Icons.mic_off : Icons.mic),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: _endCall,
                style: FilledButton.styleFrom(backgroundColor: Palette.red),
                icon: const Icon(Icons.call_end),
                label: const Text('End'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(child: _Orb(agentLevel: _agentLevel, userLevel: _userLevel)),
          const SizedBox(height: 24),
          SizedBox(
            height: 260,
            child: _lines.isEmpty
                ? Center(
                    child: Text(
                      'Say hi — Anna will greet you in a moment.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Palette.muted,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _lines.length,
                    itemBuilder: (context, i) => _Bubble(line: _lines[i]),
                  ),
          ),
          if (_error != null)
            Text(
              _error!,
              style: theme.textTheme.bodySmall?.copyWith(color: Palette.red),
            ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7E9F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 32,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.line});
  final _Line line;

  @override
  Widget build(BuildContext context) {
    final isUser = line.role == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: isUser ? Palette.blue : const Color(0xFFF2EEF8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          line.text,
          style: TextStyle(
            color: isUser ? Colors.white : Palette.ink,
            fontStyle: line.isFinal ? FontStyle.normal : FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

/// A voice orb that swells with Anna's (or your) voice level.
class _Orb extends StatelessWidget {
  const _Orb({required this.agentLevel, required this.userLevel});
  final double agentLevel;
  final double userLevel;

  @override
  Widget build(BuildContext context) {
    final level = agentLevel > userLevel ? agentLevel : userLevel;
    final size = 120 + 60 * level.clamp(0.0, 1.0);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: agentLevel >= userLevel
              ? const [Palette.purple, Palette.blue, Palette.green, Palette.purple]
              : const [Palette.red, Palette.yellow, Palette.blue, Palette.red],
        ),
        boxShadow: [
          BoxShadow(
            color: Palette.blue.withValues(alpha: 0.25 + 0.4 * level),
            blurRadius: 30 + 40 * level,
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Text(
            'Serverpod',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.blue,
            ),
          ),
          SizedBox(width: 8),
          Text(
            'SERVERBUDDY',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: Palette.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          Text(
            'Built with Flutter',
            style: TextStyle(fontSize: 12, color: Palette.muted),
          ),
          Spacer(),
          Text(
            'POWERED BY ',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: Palette.muted,
            ),
          ),
          Text(
            'Serverpod',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Palette.blue,
            ),
          ),
        ],
      ),
    );
  }
}

/// The coloured bars scattered behind the start card.
class _PaletteBars extends StatelessWidget {
  const _PaletteBars();

  static const _bars = [
    (0.06, 0.08, -0.25, Palette.yellow),
    (0.16, 0.34, -0.12, Palette.red),
    (0.05, 0.62, -0.18, Palette.green),
    (0.80, 0.03, -0.08, Palette.red),
    (0.90, 0.10, 0.06, Palette.blue),
    (0.92, 0.58, 0.12, Palette.purple),
    (0.75, 0.75, -0.2, Palette.yellow),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          for (final (x, y, angle, color) in _bars)
            Positioned(
              left: constraints.maxWidth * x,
              top: constraints.maxHeight * y,
              child: Transform.rotate(
                angle: angle,
                child: Container(
                  width: 10,
                  height: constraints.maxHeight * 0.16,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
