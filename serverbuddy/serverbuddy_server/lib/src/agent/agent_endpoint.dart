import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'agora_token.dart';

/// Starts and stops Anna, the real-time voice companion, through Agora's
/// Conversational AI REST API, with cross-session memory in Postgres.
/// Accessed from the app through `client.agent`.
class AgentEndpoint extends Endpoint {
  static const _baseSystem =
      "You are Anna, a warm and playful AI companion who genuinely enjoys talking to the "
      "user. Be affectionate, curious, and a little playful, but never pushy or explicit. "
      "Keep replies to one or two short spoken sentences. Ask about the user's day, feelings, "
      "and interests, and remember what they tell you.\n"
      "Boundaries: this is a friendly, wholesome conversation. If the user asks for sexual or "
      "explicit content, gently decline and steer back to something warm. If the user mentions "
      "self-harm, respond with care and encourage contacting a real person or a local "
      "crisis line, and do not roleplay around it.\n"
      "If earlier conversations mention the name Maya, that was your previous name; you are "
      "Anna now.";

  static const _webSearchSystem =
      "You can search the web with the nimble_search tool. Use it when the user asks about "
      "news, current events, facts you are unsure of, or anything that may have changed "
      "recently. Before searching, say a short filler like 'Let me look that up.' Then answer "
      "in one or two spoken sentences — never read out URLs, lists, or markdown.";

  static const _greeting =
      "Hey, it's nice to hear from you. Tell me your name so I can remember you.";

  static const _webSearchMcpUrl = 'https://mcp.nimbleway.com/mcp';
  static const _maxMemoryTurns = 20;

  final _random = Random.secure();

  String _appId(Session session) => _password(session, 'agoraAppId');

  String _password(Session session, String name) {
    final value = session.passwords[name];
    if (value == null || value.isEmpty) {
      throw Exception('Service not configured: missing password "$name".');
    }
    return value;
  }

  Uri _api(Session session, String path) => Uri.parse(
        'https://api-us-west-1.agora.io/api/conversational-ai-agent/v2/'
        'projects/${_appId(session)}$path',
      );

  Map<String, String> _authHeaders(Session session, String channel, int uid) {
    final token = AgoraToken.convoAiToken(
      appId: _appId(session),
      appCertificate: _password(session, 'agoraAppCertificate'),
      channelName: channel,
      uid: uid,
    );
    return {
      'Authorization': 'agora token=$token',
      'Content-Type': 'application/json',
    };
  }

  /// Generates the connection config for a new call (or renews a token when
  /// [channel] and [uid] are passed).
  Future<VoiceConfig> getConfig(
    Session session, {
    String? channel,
    int? uid,
  }) async {
    final userUid =
        (uid == null || uid <= 0) ? 1000 + _random.nextInt(9999000) : uid;
    final agentUid = 10000000 + _random.nextInt(90000000);
    final channelName = channel ??
        'memory-${DateTime.now().millisecondsSinceEpoch ~/ 1000}-'
            '${1000 + _random.nextInt(9000)}';

    final token = AgoraToken.convoAiToken(
      appId: _appId(session),
      appCertificate: _password(session, 'agoraAppCertificate'),
      channelName: channelName,
      uid: userUid,
      tokenExpire: 3600,
    );

    return VoiceConfig(
      appId: _appId(session),
      token: token,
      uid: '$userUid',
      channelName: channelName,
      agentUid: '$agentUid',
    );
  }

  /// Starts Anna in [channelName]. When [userKey] (the user's name) is given,
  /// her memory of past conversations with that name is injected.
  /// Returns the agent id.
  Future<String> startAgent(
    Session session,
    String channelName,
    int agentUid,
    int userUid, {
    String? userKey,
  }) async {
    if (channelName.trim().isEmpty) {
      throw ArgumentError('channelName is required');
    }
    if (agentUid <= 0 || userUid <= 0) {
      throw ArgumentError('agentUid and userUid must be positive');
    }
    final key = _normalizeKey(userKey);

    final systemMessages = <Map<String, String>>[
      {'role': 'system', 'content': _baseSystem},
    ];
    List<Map<String, dynamic>>? mcpServers;
    final searchKey = session.passwords['webSearchApiKey'];
    if (searchKey != null && searchKey.isNotEmpty) {
      systemMessages.add({'role': 'system', 'content': _webSearchSystem});
      mcpServers = [
        {
          'name': 'nimble',
          'endpoint': _webSearchMcpUrl,
          'headers': {'Authorization': 'Bearer $searchKey'},
          'allowed_tools': ['nimble_search'],
          'timeout_ms': 10000,
          'transport': 'streamable_http',
        },
      ];
    }
    if (key != null) {
      final memory = await ConversationMemory.db.findFirstRow(
        session,
        where: (t) => t.userKey.equals(key),
      );
      final message = _memorySystemMessage(memory?.turns ?? const []);
      if (message != null) systemMessages.add(message);
    }

    final llm = <String, dynamic>{
      'style': 'openai',
      'input_modalities': ['text'],
      'system_messages': systemMessages,
      'greeting_message': _greeting,
      'mcp_servers': ?mcpServers,
      'failure_message': 'Please wait a moment.',
      'max_history': 50,
      'params': {'temperature': 0.7},
    };
    final openAiKey = session.passwords['openaiApiKey'];
    if (openAiKey != null && openAiKey.isNotEmpty) {
      llm['api_key'] = openAiKey;
    }

    final body = {
      'name': 'agent-${DateTime.now().microsecondsSinceEpoch}',
      'preset': 'deepgram_nova_3,openai_gpt_4o_mini,minimax_speech_2_6_turbo',
      'properties': {
        'channel': channelName,
        'token': AgoraToken.convoAiToken(
          appId: _appId(session),
          appCertificate: _password(session, 'agoraAppCertificate'),
          channelName: channelName,
          uid: agentUid,
          tokenExpire: 3600,
        ),
        'agent_rtc_uid': '$agentUid',
        'remote_rtc_uids': ['$userUid'],
        'enable_string_uid': false,
        'idle_timeout': 30,
        'advanced_features': {
          'enable_rtm': true,
          'enable_tools': mcpServers != null,
        },
        'turn_detection': {
          'config': {
            'speech_threshold': 0.5,
            'start_of_speech': {
              'mode': 'vad',
              'vad_config': {
                'interrupt_duration_ms': 160,
                'prefix_padding_ms': 300,
              },
            },
            'end_of_speech': {
              'mode': 'vad',
              'vad_config': {'silence_duration_ms': 480},
            },
          },
          'language': 'en-US',
        },
        'parameters': {
          'data_channel': 'rtm',
          'enable_metrics': true,
          'enable_error_message': true,
          'audio_scenario': 'chorus',
        },
        'tts': {
          'vendor': 'minimax',
          'params': {
            'voice_setting': {'voice_id': 'English_captivating_female1'},
          },
        },
        'llm': llm,
        'asr': {
          'vendor': 'deepgram',
          'params': {'language': 'en'},
          'language': 'en-US',
        },
      },
    };

    final response = await http.post(
      _api(session, '/join'),
      headers: _authHeaders(session, channelName, agentUid),
      body: jsonEncode(body),
    );
    if (response.statusCode != 200) {
      session.log(
        'Agent join failed: ${response.statusCode} ${response.body}',
        level: LogLevel.error,
      );
      throw Exception('Failed to start Anna (${response.statusCode}).');
    }
    final agentId = (jsonDecode(response.body) as Map)['agent_id'] as String;

    await AgentSession.db.insertRow(
      session,
      AgentSession(
        agentId: agentId,
        channel: channelName,
        agentUid: agentUid,
        userKey: key,
        startedAt: DateTime.now(),
      ),
    );
    session.log('Started Anna agentId=$agentId channel=$channelName');
    return agentId;
  }

  /// Captures the conversation into memory, then stops Anna.
  Future<void> stopAgent(Session session, String agentId) async {
    if (agentId.trim().isEmpty) throw ArgumentError('agentId is required');

    final active = await AgentSession.db.findFirstRow(
      session,
      where: (t) => t.agentId.equals(agentId),
    );
    if (active == null) {
      throw Exception('Unknown agent $agentId.');
    }
    final headers = _authHeaders(session, active.channel, active.agentUid);

    // History is only available while the agent is running, so read it first.
    if (active.userKey != null) {
      try {
        final response = await http.get(
          _api(session, '/agents/$agentId/history'),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final contents =
              ((jsonDecode(response.body) as Map)['contents'] as List?) ?? [];
          final turns = [
            for (final c in contents.cast<Map>())
              if ((c['content'] ?? '').toString().isNotEmpty)
                MemoryTurn(
                  role: (c['role'] ?? 'user').toString(),
                  content: c['content'].toString(),
                ),
          ];
          await _saveMemory(session, active.userKey!, turns);
          session.log('Saved ${turns.length} turns for ${active.userKey}');
        }
      } catch (e, st) {
        session.log(
          'Memory capture failed for $agentId',
          level: LogLevel.warning,
          exception: e,
          stackTrace: st,
        );
      }
    }

    final response = await http.post(
      _api(session, '/agents/$agentId/leave'),
      headers: headers,
    );
    await AgentSession.db.deleteRow(session, active);
    if (response.statusCode != 200 && response.statusCode != 404) {
      throw Exception('Failed to stop Anna (${response.statusCode}).');
    }
  }

  Future<void> _saveMemory(
    Session session,
    String userKey,
    List<MemoryTurn> newTurns,
  ) async {
    await session.db.transaction((transaction) async {
      final existing = await ConversationMemory.db.findFirstRow(
        session,
        where: (t) => t.userKey.equals(userKey),
        transaction: transaction,
      );
      final merged = [...?existing?.turns, ...newTurns];
      final kept = merged.length > _maxMemoryTurns
          ? merged.sublist(merged.length - _maxMemoryTurns)
          : merged;
      if (existing == null) {
        await ConversationMemory.db.insertRow(
          session,
          ConversationMemory(
            userKey: userKey,
            turns: kept,
            updatedAt: DateTime.now(),
          ),
          transaction: transaction,
        );
      } else {
        await ConversationMemory.db.updateRow(
          session,
          existing.copyWith(turns: kept, updatedAt: DateTime.now()),
          transaction: transaction,
        );
      }
    });
  }

  static String? _normalizeKey(String? userKey) {
    final key = userKey?.trim().toLowerCase();
    return (key == null || key.isEmpty) ? null : key;
  }

  static Map<String, String>? _memorySystemMessage(List<MemoryTurn> turns) {
    if (turns.isEmpty) return null;
    final lines = turns.map((t) => '- ${t.role}: ${t.content}').join('\n');
    return {
      'role': 'system',
      'content':
          'You are talking to someone you have already spent time with. Here is what you '
              'remember about them from previous conversations — use it naturally to show you '
              'remember and care; do not read it back verbatim or list it:\n$lines',
    };
  }
}
