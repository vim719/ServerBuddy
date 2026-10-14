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
import 'package:serverbuddy_client/src/protocol/protocol.dart' as _idsq3xhi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../agent/user_memory.dart' as _inbeku16;

/// Anna's cross-session memory for one user, re-injected on their next call.
abstract class ConversationMemory
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConversationMemory._({
    this.id,
    required this.userKey,
    required this.turns,
    required this.updatedAt,
  });

  factory ConversationMemory({
    int? id,
    required String userKey,
    required List<_inbeku16.MemoryTurn> turns,
    required DateTime updatedAt,
  }) = _ConversationMemoryImpl;

  factory ConversationMemory.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConversationMemory(
      id: jsonSerialization['id'] as int?,
      userKey: jsonSerialization['userKey'] as String,
      turns: _idsq3xhi.Protocol().deserialize<List<_inbeku16.MemoryTurn>>(
        jsonSerialization['turns'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// The name the user gave (lowercased)
  String userKey;

  /// The most recent turns, oldest first
  List<_inbeku16.MemoryTurn> turns;

  /// When the memory was last updated
  DateTime updatedAt;

  /// Returns a shallow copy of this [ConversationMemory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConversationMemory copyWith({
    int? id,
    String? userKey,
    List<_inbeku16.MemoryTurn>? turns,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationMemory',
      if (id != null) 'id': id,
      'userKey': userKey,
      'turns': turns.toJson(valueToJson: (v) => v.toJson()),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationMemory',
      if (id != null) 'id': id,
      'userKey': userKey,
      'turns': turns.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationMemoryImpl extends ConversationMemory {
  _ConversationMemoryImpl({
    int? id,
    required String userKey,
    required List<_inbeku16.MemoryTurn> turns,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userKey: userKey,
         turns: turns,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ConversationMemory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConversationMemory copyWith({
    Object? id = _Undefined,
    String? userKey,
    List<_inbeku16.MemoryTurn>? turns,
    DateTime? updatedAt,
  }) {
    return ConversationMemory(
      id: id is int? ? id : this.id,
      userKey: userKey ?? this.userKey,
      turns: turns ?? this.turns.map((e0) => e0.copyWith()).toList(),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
