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

/// A memory that Anna, the ServerBuddy companion, keeps about the user
abstract class Memory
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Memory._({
    this.id,
    required this.author,
    required this.text,
    required this.date,
  });

  factory Memory({
    int? id,
    required String author,
    required String text,
    required DateTime date,
  }) = _MemoryImpl;

  factory Memory.fromJson(Map<String, dynamic> jsonSerialization) {
    return Memory(
      id: jsonSerialization['id'] as int?,
      author: jsonSerialization['author'] as String,
      text: jsonSerialization['text'] as String,
      date: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Who the memory belongs to
  String author;

  /// The memory text
  String text;

  /// The date the memory was saved
  DateTime date;

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Memory copyWith({
    int? id,
    String? author,
    String? text,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Memory',
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'date': date.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Memory',
      if (id != null) 'id': id,
      'author': author,
      'text': text,
      'date': date.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryImpl extends Memory {
  _MemoryImpl({
    int? id,
    required String author,
    required String text,
    required DateTime date,
  }) : super._(
         id: id,
         author: author,
         text: text,
         date: date,
       );

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Memory copyWith({
    Object? id = _Undefined,
    String? author,
    String? text,
    DateTime? date,
  }) {
    return Memory(
      id: id is int? ? id : this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      date: date ?? this.date,
    );
  }
}
