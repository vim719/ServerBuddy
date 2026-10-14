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
import 'package:serverpod/serverpod.dart' as _is;

/// A memory that Anna, the ServerBuddy companion, keeps about the user
abstract class Memory implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      date: _is.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  static final t = MemoryTable();

  static const db = MemoryRepository._();

  @override
  int? id;

  /// Who the memory belongs to
  String author;

  /// The memory text
  String text;

  /// The date the memory was saved
  DateTime date;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static MemoryInclude include() {
    return MemoryInclude._();
  }

  static MemoryIncludeList includeList({
    _is.WhereExpressionBuilder<MemoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MemoryTable>? orderBy,
    _is.OrderByListBuilder<MemoryTable>? orderByList,
    MemoryInclude? include,
  }) {
    return MemoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class MemoryUpdateTable extends _is.UpdateTable<MemoryTable> {
  MemoryUpdateTable(super.table);

  _is.ColumnValue<String, String> author(String value) => _is.ColumnValue(
    table.author,
    value,
  );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> date(DateTime value) => _is.ColumnValue(
    table.date,
    value,
  );
}

class MemoryTable extends _is.Table<int?> {
  MemoryTable({super.tableRelation}) : super(tableName: 'memories') {
    updateTable = MemoryUpdateTable(this);
    author = _is.ColumnString(
      'author',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    date = _is.ColumnDateTime(
      'date',
      this,
    );
  }

  late final MemoryUpdateTable updateTable;

  /// Who the memory belongs to
  late final _is.ColumnString author;

  /// The memory text
  late final _is.ColumnString text;

  /// The date the memory was saved
  late final _is.ColumnDateTime date;

  @override
  List<_is.Column> get columns => [
    id,
    author,
    text,
    date,
  ];
}

class MemoryInclude extends _is.IncludeObject {
  MemoryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Memory.t;
}

class MemoryIncludeList extends _is.IncludeList {
  MemoryIncludeList._({
    _is.WhereExpressionBuilder<MemoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Memory.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Memory.t;
}

class MemoryRepository {
  const MemoryRepository._();

  /// Returns a list of [Memory]s matching the given query parameters.
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
  Future<List<Memory>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MemoryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MemoryTable>? orderBy,
    _is.OrderByListBuilder<MemoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Memory>(
      where: where?.call(Memory.t),
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Memory] matching the given query parameters.
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
  Future<Memory?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MemoryTable>? where,
    int? offset,
    _is.OrderByBuilder<MemoryTable>? orderBy,
    _is.OrderByListBuilder<MemoryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Memory>(
      where: where?.call(Memory.t),
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Memory] by its [id] or null if no such row exists.
  Future<Memory?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Memory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Memory]s in the list and returns the inserted rows.
  ///
  /// The returned [Memory]s will have their `id` fields set.
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
  Future<List<Memory>> insert(
    _is.DatabaseSession session,
    List<Memory> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Memory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Memory] and returns the inserted row.
  ///
  /// The returned [Memory] will have its `id` field set.
  Future<Memory> insertRow(
    _is.DatabaseSession session,
    Memory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Memory>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Memory]s in the list and returns the resulting rows.
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
  /// The returned [Memory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Memory>> upsert(
    _is.DatabaseSession session,
    List<Memory> rows, {
    required _is.ColumnSelections<MemoryTable> conflictColumns,
    _is.ColumnSelections<MemoryTable>? updateColumns,
    _is.WhereExpressionBuilder<MemoryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Memory>(
      rows,
      conflictColumns: conflictColumns(Memory.t),
      updateColumns: updateColumns?.call(Memory.t),
      updateWhere: updateWhere?.call(Memory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Memory] and returns the resulting row.
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
  /// The returned [Memory] will have its `id` field set.
  Future<Memory?> upsertRow(
    _is.DatabaseSession session,
    Memory row, {
    required _is.ColumnSelections<MemoryTable> conflictColumns,
    _is.ColumnSelections<MemoryTable>? updateColumns,
    _is.WhereExpressionBuilder<MemoryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Memory>(
      row,
      conflictColumns: conflictColumns(Memory.t),
      updateColumns: updateColumns?.call(Memory.t),
      updateWhere: updateWhere?.call(Memory.t),
      transaction: transaction,
    );
  }

  /// Updates all [Memory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Memory>> update(
    _is.DatabaseSession session,
    List<Memory> rows, {
    _is.ColumnSelections<MemoryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Memory>(
      rows,
      columns: columns?.call(Memory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Memory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Memory> updateRow(
    _is.DatabaseSession session,
    Memory row, {
    _is.ColumnSelections<MemoryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Memory>(
      row,
      columns: columns?.call(Memory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Memory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Memory?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MemoryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Memory>(
      id,
      columnValues: columnValues(Memory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Memory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Memory>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MemoryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MemoryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MemoryTable>? orderBy,
    _is.OrderByListBuilder<MemoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Memory>(
      columnValues: columnValues(Memory.t.updateTable),
      where: where(Memory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Memory]s in the list and returns the deleted rows.
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
  Future<List<Memory>> delete(
    _is.DatabaseSession session,
    List<Memory> rows, {
    _is.OrderByBuilder<MemoryTable>? orderBy,
    _is.OrderByListBuilder<MemoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Memory>(
      rows,
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Memory].
  Future<Memory> deleteRow(
    _is.DatabaseSession session,
    Memory row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Memory>(
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
  Future<List<Memory>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MemoryTable> where,
    _is.OrderByBuilder<MemoryTable>? orderBy,
    _is.OrderByListBuilder<MemoryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Memory>(
      where: where(Memory.t),
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MemoryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Memory>(
      where: where?.call(Memory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Memory] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MemoryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Memory>(
      where: where(Memory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
