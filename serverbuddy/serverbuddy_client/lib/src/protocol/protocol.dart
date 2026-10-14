/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverbuddy_client/src/protocol/memories/memory.dart'
    as _i6ww7ycq;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'agent/agent_models.dart' as _ipc7s44r;
import 'agent/agent_session.dart' as _i7id10wv;
import 'agent/conversation_memory.dart' as _isrrilcy;
import 'agent/user_memory.dart' as _ip4n01qu;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'memories/memory.dart' as _ipyddou1;
export 'agent/agent_models.dart';
export 'agent/agent_session.dart';
export 'agent/conversation_memory.dart';
export 'agent/user_memory.dart';
export 'greetings/greeting.dart';
export 'memories/memory.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ipc7s44r.VoiceConfig) {
      return _ipc7s44r.VoiceConfig.fromJson(data) as T;
    }
    if (t == _i7id10wv.AgentSession) {
      return _i7id10wv.AgentSession.fromJson(data) as T;
    }
    if (t == _isrrilcy.ConversationMemory) {
      return _isrrilcy.ConversationMemory.fromJson(data) as T;
    }
    if (t == _ip4n01qu.MemoryTurn) {
      return _ip4n01qu.MemoryTurn.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ipyddou1.Memory) {
      return _ipyddou1.Memory.fromJson(data) as T;
    }
    if (t == _isc.getType<_ipc7s44r.VoiceConfig?>()) {
      return (data != null ? _ipc7s44r.VoiceConfig.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7id10wv.AgentSession?>()) {
      return (data != null ? _i7id10wv.AgentSession.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isrrilcy.ConversationMemory?>()) {
      return (data != null ? _isrrilcy.ConversationMemory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ip4n01qu.MemoryTurn?>()) {
      return (data != null ? _ip4n01qu.MemoryTurn.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipyddou1.Memory?>()) {
      return (data != null ? _ipyddou1.Memory.fromJson(data) : null) as T;
    }
    if (t == List<_ip4n01qu.MemoryTurn>) {
      return (data as List)
              .map((e) => deserialize<_ip4n01qu.MemoryTurn>(e))
              .toList()
          as T;
    }
    if (t == List<_i6ww7ycq.Memory>) {
      return (data as List)
              .map((e) => deserialize<_i6ww7ycq.Memory>(e))
              .toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ipc7s44r.VoiceConfig => 'VoiceConfig',
      _i7id10wv.AgentSession => 'AgentSession',
      _isrrilcy.ConversationMemory => 'ConversationMemory',
      _ip4n01qu.MemoryTurn => 'MemoryTurn',
      _izw8z7ou.Greeting => 'Greeting',
      _ipyddou1.Memory => 'Memory',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('serverbuddy.', '');
    }

    switch (data) {
      case _ipc7s44r.VoiceConfig():
        return 'VoiceConfig';
      case _i7id10wv.AgentSession():
        return 'AgentSession';
      case _isrrilcy.ConversationMemory():
        return 'ConversationMemory';
      case _ip4n01qu.MemoryTurn():
        return 'MemoryTurn';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ipyddou1.Memory():
        return 'Memory';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'VoiceConfig') {
      return deserialize<_ipc7s44r.VoiceConfig>(data['data']);
    }
    if (dataClassName == 'AgentSession') {
      return deserialize<_i7id10wv.AgentSession>(data['data']);
    }
    if (dataClassName == 'ConversationMemory') {
      return deserialize<_isrrilcy.ConversationMemory>(data['data']);
    }
    if (dataClassName == 'MemoryTurn') {
      return deserialize<_ip4n01qu.MemoryTurn>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'Memory') {
      return deserialize<_ipyddou1.Memory>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  String getModuleName() => 'serverbuddy';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
