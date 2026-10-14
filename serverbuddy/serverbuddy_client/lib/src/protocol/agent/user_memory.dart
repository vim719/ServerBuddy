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

/// One remembered conversation turn.
abstract class MemoryTurn
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MemoryTurn._({
    required this.role,
    required this.content,
  });

  factory MemoryTurn({
    required String role,
    required String content,
  }) = _MemoryTurnImpl;

  factory MemoryTurn.fromJson(Map<String, dynamic> jsonSerialization) {
    return MemoryTurn(
      role: jsonSerialization['role'] as String,
      content: jsonSerialization['content'] as String,
    );
  }

  /// "user" or "assistant"
  String role;

  /// What was said
  String content;

  /// Returns a shallow copy of this [MemoryTurn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MemoryTurn copyWith({
    String? role,
    String? content,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MemoryTurn',
      'role': role,
      'content': content,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MemoryTurn',
      'role': role,
      'content': content,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _MemoryTurnImpl extends MemoryTurn {
  _MemoryTurnImpl({
    required String role,
    required String content,
  }) : super._(
         role: role,
         content: content,
       );

  /// Returns a shallow copy of this [MemoryTurn]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MemoryTurn copyWith({
    String? role,
    String? content,
  }) {
    return MemoryTurn(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }
}
