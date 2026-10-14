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
import 'package:serverbuddy_server/src/generated/protocol.dart' as _ir0bj6ur;
import 'package:serverpod/serverpod.dart' as _is;
import '../agent/user_memory.dart' as _inbeku16;

/// Anna's cross-session memory for one user, re-injected on their next call.
abstract class ConversationMemory
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      turns: _ir0bj6ur.Protocol().deserialize<List<_inbeku16.MemoryTurn>>(
        jsonSerialization['turns'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ConversationMemoryTable();

  static const db = ConversationMemoryRepository._();

  @override
  int? id;

  /// The name the user gave (lowercased)
  String userKey;

  /// The most recent turns, oldest first
  List<_inbeku16.MemoryTurn> turns;

  /// When the memory was last updated
  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ConversationMemory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ConversationMemoryInclude include() {
    return ConversationMemoryInclude._();
  }

  static ConversationMemoryIncludeList includeList({
    _is.WhereExpressionBuilder<ConversationMemoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConversationMemoryTable>? orderBy,
    _is.OrderByListBuilder<ConversationMemoryTable>? orderByList,
    ConversationMemoryInclude? include,
  }) {
    return ConversationMemoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationMemory.t),
      orderByList: orderByList?.call(ConversationMemory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ConversationMemoryUpdateTable
    extends _is.UpdateTable<ConversationMemoryTable> {
  ConversationMemoryUpdateTable(super.table);

  _is.ColumnValue<String, String> userKey(String value) => _is.ColumnValue(
    table.userKey,
    value,
  );

  _is.ColumnValue<List<_inbeku16.MemoryTurn>, List<_inbeku16.MemoryTurn>> turns(
    List<_inbeku16.MemoryTurn> value,
  ) => _is.ColumnValue(
    table.turns,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ConversationMemoryTable extends _is.Table<int?> {
  ConversationMemoryTable({super.tableRelation})
    : super(tableName: 'conversation_memories') {
    updateTable = ConversationMemoryUpdateTable(this);
    userKey = _is.ColumnString(
      'userKey',
      this,
    );
    turns = _is.ColumnSerializable<List<_inbeku16.MemoryTurn>>(
      'turns',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ConversationMemoryUpdateTable updateTable;

  /// The name the user gave (lowercased)
  late final _is.ColumnString userKey;

  /// The most recent turns, oldest first
  late final _is.ColumnSerializable<List<_inbeku16.MemoryTurn>> turns;

  /// When the memory was last updated
  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userKey,
    turns,
    updatedAt,
  ];
}

class ConversationMemoryInclude extends _is.IncludeObject {
  ConversationMemoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ConversationMemory.t;
}

class ConversationMemoryIncludeList extends _is.IncludeList {
  ConversationMemoryIncludeList._({
    _is.WhereExpressionBuilder<ConversationMemoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConversationMemory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ConversationMemory.t;
}

class ConversationMemoryRepository {
  const ConversationMemoryRepository._();

  /// Returns a list of [ConversationMemory]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ConversationMemory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConversationMemoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConversationMemoryTable>? orderBy,
    _is.OrderByListBuilder<ConversationMemoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ConversationMemory>(
      where: where?.call(ConversationMemory.t),
      orderBy: orderBy?.call(ConversationMemory.t),
      orderByList: orderByList?.call(ConversationMemory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ConversationMemory] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ConversationMemory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConversationMemoryTable>? where,
    int? offset,
    _is.OrderByBuilder<ConversationMemoryTable>? orderBy,
    _is.OrderByListBuilder<ConversationMemoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ConversationMemory>(
      where: where?.call(ConversationMemory.t),
      orderBy: orderBy?.call(ConversationMemory.t),
      orderByList: orderByList?.call(ConversationMemory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ConversationMemory] by its [id] or null if no such row exists.
  Future<ConversationMemory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ConversationMemory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ConversationMemory]s in the list and returns the inserted rows.
  ///
  /// The returned [ConversationMemory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationMemory>> insert(
    _is.DatabaseSession session,
    List<ConversationMemory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ConversationMemory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ConversationMemory] and returns the inserted row.
  ///
  /// The returned [ConversationMemory] will have its `id` field set.
  Future<ConversationMemory> insertRow(
    _is.DatabaseSession session,
    ConversationMemory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConversationMemory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ConversationMemory]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ConversationMemory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationMemory>> upsert(
    _is.DatabaseSession session,
    List<ConversationMemory> rows, {
    required _is.ColumnSelections<ConversationMemoryTable> conflictColumns,
    _is.ColumnSelections<ConversationMemoryTable>? updateColumns,
    _is.WhereExpressionBuilder<ConversationMemoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ConversationMemory>(
      rows,
      conflictColumns: conflictColumns(ConversationMemory.t),
      updateColumns: updateColumns?.call(ConversationMemory.t),
      updateWhere: updateWhere?.call(ConversationMemory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ConversationMemory] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ConversationMemory] will have its `id` field set.
  Future<ConversationMemory?> upsertRow(
    _is.DatabaseSession session,
    ConversationMemory row, {
    required _is.ColumnSelections<ConversationMemoryTable> conflictColumns,
    _is.ColumnSelections<ConversationMemoryTable>? updateColumns,
    _is.WhereExpressionBuilder<ConversationMemoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ConversationMemory>(
      row,
      conflictColumns: conflictColumns(ConversationMemory.t),
      updateColumns: updateColumns?.call(ConversationMemory.t),
      updateWhere: updateWhere?.call(ConversationMemory.t),
      transaction: transaction,
    );
  }

  /// Updates all [ConversationMemory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationMemory>> update(
    _is.DatabaseSession session,
    List<ConversationMemory> rows, {
    _is.ColumnSelections<ConversationMemoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ConversationMemory>(
      rows,
      columns: columns?.call(ConversationMemory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ConversationMemory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConversationMemory> updateRow(
    _is.DatabaseSession session,
    ConversationMemory row, {
    _is.ColumnSelections<ConversationMemoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConversationMemory>(
      row,
      columns: columns?.call(ConversationMemory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConversationMemory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ConversationMemory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ConversationMemoryUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ConversationMemory>(
      id,
      columnValues: columnValues(ConversationMemory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ConversationMemory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationMemory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ConversationMemoryUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ConversationMemoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConversationMemoryTable>? orderBy,
    _is.OrderByListBuilder<ConversationMemoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ConversationMemory>(
      columnValues: columnValues(ConversationMemory.t.updateTable),
      where: where(ConversationMemory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationMemory.t),
      orderByList: orderByList?.call(ConversationMemory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ConversationMemory]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationMemory>> delete(
    _is.DatabaseSession session,
    List<ConversationMemory> rows, {
    _is.OrderByBuilder<ConversationMemoryTable>? orderBy,
    _is.OrderByListBuilder<ConversationMemoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ConversationMemory>(
      rows,
      orderBy: orderBy?.call(ConversationMemory.t),
      orderByList: orderByList?.call(ConversationMemory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ConversationMemory].
  Future<ConversationMemory> deleteRow(
    _is.DatabaseSession session,
    ConversationMemory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConversationMemory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConversationMemory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConversationMemoryTable> where,
    _is.OrderByBuilder<ConversationMemoryTable>? orderBy,
    _is.OrderByListBuilder<ConversationMemoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ConversationMemory>(
      where: where(ConversationMemory.t),
      orderBy: orderBy?.call(ConversationMemory.t),
      orderByList: orderByList?.call(ConversationMemory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConversationMemoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ConversationMemory>(
      where: where?.call(ConversationMemory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ConversationMemory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConversationMemoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ConversationMemory>(
      where: where(ConversationMemory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
