import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Stores and lists the memories Anna keeps between conversations.
/// Accessed from the app through `client.memory`.
class MemoryEndpoint extends Endpoint {
  /// Saves a new memory and returns the stored row with its `id`.
  Future<Memory> remember(Session session, String author, String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Memory text must not be empty');
    }

    final memory = Memory(
      author: author.trim().isEmpty ? 'You' : author.trim(),
      text: trimmed,
      date: DateTime.now(),
    );

    return Memory.db.insertRow(session, memory);
  }

  /// Returns all memories saved in the database, most recent first.
  Future<List<Memory>> getMemories(Session session) async {
    return Memory.db.find(session, orderBy: (t) => t.date.desc());
  }

  /// Deletes a memory by id.
  Future<void> forget(Session session, int id) async {
    final memory = await Memory.db.findById(session, id);
    if (memory != null) {
      await Memory.db.deleteRow(session, memory);
    }
  }
}
