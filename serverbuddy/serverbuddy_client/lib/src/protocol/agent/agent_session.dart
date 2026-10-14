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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// A running voice agent, kept so stop can capture memory even after a restart.
abstract class AgentSession
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AgentSession._({
    this.id,
    required this.agentId,
    required this.channel,
    required this.agentUid,
    this.userKey,
    required this.startedAt,
  });

  factory AgentSession({
    int? id,
    required String agentId,
    required String channel,
    required int agentUid,
    String? userKey,
    required DateTime startedAt,
  }) = _AgentSessionImpl;

  factory AgentSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return AgentSession(
      id: jsonSerialization['id'] as int?,
      agentId: jsonSerialization['agentId'] as String,
      channel: jsonSerialization['channel'] as String,
      agentUid: jsonSerialization['agentUid'] as int,
      userKey: jsonSerialization['userKey'] as String?,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The id Agora returned for the running agent
  String agentId;

  /// The channel the agent joined
  String channel;

  /// The agent's numeric RTC uid
  int agentUid;

  /// The user's name (memory key), or null when anonymous
  String? userKey;

  /// When the agent was started
  DateTime startedAt;

  /// Returns a shallow copy of this [AgentSession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AgentSession copyWith({
    int? id,
    String? agentId,
    String? channel,
    int? agentUid,
    String? userKey,
    DateTime? startedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AgentSession',
      if (id != null) 'id': id,
      'agentId': agentId,
      'channel': channel,
      'agentUid': agentUid,
      if (userKey != null) 'userKey': userKey,
      'startedAt': startedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AgentSession',
      if (id != null) 'id': id,
      'agentId': agentId,
      'channel': channel,
      'agentUid': agentUid,
      if (userKey != null) 'userKey': userKey,
      'startedAt': startedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AgentSessionImpl extends AgentSession {
  _AgentSessionImpl({
    int? id,
    required String agentId,
    required String channel,
    required int agentUid,
    String? userKey,
    required DateTime startedAt,
  }) : super._(
         id: id,
         agentId: agentId,
         channel: channel,
         agentUid: agentUid,
         userKey: userKey,
         startedAt: startedAt,
       );

  /// Returns a shallow copy of this [AgentSession]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AgentSession copyWith({
    Object? id = _Undefined,
    String? agentId,
    String? channel,
    int? agentUid,
    Object? userKey = _Undefined,
    DateTime? startedAt,
  }) {
    return AgentSession(
      id: id is int? ? id : this.id,
      agentId: agentId ?? this.agentId,
      channel: channel ?? this.channel,
      agentUid: agentUid ?? this.agentUid,
      userKey: userKey is String? ? userKey : this.userKey,
      startedAt: startedAt ?? this.startedAt,
    );
  }
}
