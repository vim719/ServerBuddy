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

/// A running voice agent, kept so stop can capture memory even after a restart.
abstract class AgentSession
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
    );
  }

  static final t = AgentSessionTable();

  static const db = AgentSessionRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AgentSession]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static AgentSessionInclude include() {
    return AgentSessionInclude._();
  }

  static AgentSessionIncludeList includeList({
    _is.WhereExpressionBuilder<AgentSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgentSessionTable>? orderBy,
    _is.OrderByListBuilder<AgentSessionTable>? orderByList,
    AgentSessionInclude? include,
  }) {
    return AgentSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AgentSession.t),
      orderByList: orderByList?.call(AgentSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class AgentSessionUpdateTable extends _is.UpdateTable<AgentSessionTable> {
  AgentSessionUpdateTable(super.table);

  _is.ColumnValue<String, String> agentId(String value) => _is.ColumnValue(
    table.agentId,
    value,
  );

  _is.ColumnValue<String, String> channel(String value) => _is.ColumnValue(
    table.channel,
    value,
  );

  _is.ColumnValue<int, int> agentUid(int value) => _is.ColumnValue(
    table.agentUid,
    value,
  );

  _is.ColumnValue<String, String> userKey(String? value) => _is.ColumnValue(
    table.userKey,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );
}

class AgentSessionTable extends _is.Table<int?> {
  AgentSessionTable({super.tableRelation})
    : super(tableName: 'agent_sessions') {
    updateTable = AgentSessionUpdateTable(this);
    agentId = _is.ColumnString(
      'agentId',
      this,
    );
    channel = _is.ColumnString(
      'channel',
      this,
    );
    agentUid = _is.ColumnInt(
      'agentUid',
      this,
    );
    userKey = _is.ColumnString(
      'userKey',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
  }

  late final AgentSessionUpdateTable updateTable;

  /// The id Agora returned for the running agent
  late final _is.ColumnString agentId;

  /// The channel the agent joined
  late final _is.ColumnString channel;

  /// The agent's numeric RTC uid
  late final _is.ColumnInt agentUid;

  /// The user's name (memory key), or null when anonymous
  late final _is.ColumnString userKey;

  /// When the agent was started
  late final _is.ColumnDateTime startedAt;

  @override
  List<_is.Column> get columns => [
    id,
    agentId,
    channel,
    agentUid,
    userKey,
    startedAt,
  ];
}

class AgentSessionInclude extends _is.IncludeObject {
  AgentSessionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AgentSession.t;
}

class AgentSessionIncludeList extends _is.IncludeList {
  AgentSessionIncludeList._({
    _is.WhereExpressionBuilder<AgentSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AgentSession.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AgentSession.t;
}

class AgentSessionRepository {
  const AgentSessionRepository._();

  /// Returns a list of [AgentSession]s matching the given query parameters.
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
  Future<List<AgentSession>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgentSessionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgentSessionTable>? orderBy,
    _is.OrderByListBuilder<AgentSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AgentSession>(
      where: where?.call(AgentSession.t),
      orderBy: orderBy?.call(AgentSession.t),
      orderByList: orderByList?.call(AgentSession.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AgentSession] matching the given query parameters.
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
  Future<AgentSession?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgentSessionTable>? where,
    int? offset,
    _is.OrderByBuilder<AgentSessionTable>? orderBy,
    _is.OrderByListBuilder<AgentSessionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AgentSession>(
      where: where?.call(AgentSession.t),
      orderBy: orderBy?.call(AgentSession.t),
      orderByList: orderByList?.call(AgentSession.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AgentSession] by its [id] or null if no such row exists.
  Future<AgentSession?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AgentSession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AgentSession]s in the list and returns the inserted rows.
  ///
  /// The returned [AgentSession]s will have their `id` fields set.
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
  Future<List<AgentSession>> insert(
    _is.DatabaseSession session,
    List<AgentSession> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AgentSession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AgentSession] and returns the inserted row.
  ///
  /// The returned [AgentSession] will have its `id` field set.
  Future<AgentSession> insertRow(
    _is.DatabaseSession session,
    AgentSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AgentSession>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AgentSession]s in the list and returns the resulting rows.
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
  /// The returned [AgentSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgentSession>> upsert(
    _is.DatabaseSession session,
    List<AgentSession> rows, {
    required _is.ColumnSelections<AgentSessionTable> conflictColumns,
    _is.ColumnSelections<AgentSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<AgentSessionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AgentSession>(
      rows,
      conflictColumns: conflictColumns(AgentSession.t),
      updateColumns: updateColumns?.call(AgentSession.t),
      updateWhere: updateWhere?.call(AgentSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AgentSession] and returns the resulting row.
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
  /// The returned [AgentSession] will have its `id` field set.
  Future<AgentSession?> upsertRow(
    _is.DatabaseSession session,
    AgentSession row, {
    required _is.ColumnSelections<AgentSessionTable> conflictColumns,
    _is.ColumnSelections<AgentSessionTable>? updateColumns,
    _is.WhereExpressionBuilder<AgentSessionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AgentSession>(
      row,
      conflictColumns: conflictColumns(AgentSession.t),
      updateColumns: updateColumns?.call(AgentSession.t),
      updateWhere: updateWhere?.call(AgentSession.t),
      transaction: transaction,
    );
  }

  /// Updates all [AgentSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgentSession>> update(
    _is.DatabaseSession session,
    List<AgentSession> rows, {
    _is.ColumnSelections<AgentSessionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AgentSession>(
      rows,
      columns: columns?.call(AgentSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AgentSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AgentSession> updateRow(
    _is.DatabaseSession session,
    AgentSession row, {
    _is.ColumnSelections<AgentSessionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AgentSession>(
      row,
      columns: columns?.call(AgentSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AgentSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AgentSession?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AgentSessionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AgentSession>(
      id,
      columnValues: columnValues(AgentSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AgentSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AgentSession>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AgentSessionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AgentSessionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AgentSessionTable>? orderBy,
    _is.OrderByListBuilder<AgentSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AgentSession>(
      columnValues: columnValues(AgentSession.t.updateTable),
      where: where(AgentSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AgentSession.t),
      orderByList: orderByList?.call(AgentSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AgentSession]s in the list and returns the deleted rows.
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
  Future<List<AgentSession>> delete(
    _is.DatabaseSession session,
    List<AgentSession> rows, {
    _is.OrderByBuilder<AgentSessionTable>? orderBy,
    _is.OrderByListBuilder<AgentSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AgentSession>(
      rows,
      orderBy: orderBy?.call(AgentSession.t),
      orderByList: orderByList?.call(AgentSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AgentSession].
  Future<AgentSession> deleteRow(
    _is.DatabaseSession session,
    AgentSession row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AgentSession>(
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
  Future<List<AgentSession>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AgentSessionTable> where,
    _is.OrderByBuilder<AgentSessionTable>? orderBy,
    _is.OrderByListBuilder<AgentSessionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AgentSession>(
      where: where(AgentSession.t),
      orderBy: orderBy?.call(AgentSession.t),
      orderByList: orderByList?.call(AgentSession.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AgentSessionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AgentSession>(
      where: where?.call(AgentSession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AgentSession] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AgentSessionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AgentSession>(
      where: where(AgentSession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
