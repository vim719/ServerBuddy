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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverbuddy_client/src/protocol/agent/agent_models.dart'
    as _ing1ky56;
import 'package:serverbuddy_client/src/protocol/greetings/greeting.dart'
    as _i3it4xdx;
import 'package:serverbuddy_client/src/protocol/memories/memory.dart'
    as _i6ww7ycq;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Starts and stops Anna, the real-time voice companion, through Agora's
/// Conversational AI REST API, with cross-session memory in Postgres.
/// Accessed from the app through `client.agent`.
/// {@category Endpoint}
class EndpointAgent extends _isc.EndpointRef {
  EndpointAgent(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'agent';

  /// Generates the connection config for a new call (or renews a token when
  /// [channel] and [uid] are passed).
  _ida.Future<_ing1ky56.VoiceConfig> getConfig({
    String? channel,
    int? uid,
  }) => caller.callServerEndpoint<_ing1ky56.VoiceConfig>(
    'agent',
    'getConfig',
    {
      'channel': channel,
      'uid': uid,
    },
  );

  /// Starts Anna in [channelName]. When [userKey] (the user's name) is given,
  /// her memory of past conversations with that name is injected.
  /// Returns the agent id.
  _ida.Future<String> startAgent(
    String channelName,
    int agentUid,
    int userUid, {
    String? userKey,
  }) => caller.callServerEndpoint<String>(
    'agent',
    'startAgent',
    {
      'channelName': channelName,
      'agentUid': agentUid,
      'userUid': userUid,
      'userKey': userKey,
    },
  );

  /// Captures the conversation into memory, then stops Anna.
  _ida.Future<void> stopAgent(String agentId) =>
      caller.callServerEndpoint<void>(
        'agent',
        'stopAgent',
        {'agentId': agentId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_i3it4xdx.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i3it4xdx.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Stores and lists the memories Anna keeps between conversations.
/// Accessed from the app through `client.memory`.
/// {@category Endpoint}
class EndpointMemory extends _isc.EndpointRef {
  EndpointMemory(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'memory';

  /// Saves a new memory and returns the stored row with its `id`.
  _ida.Future<_i6ww7ycq.Memory> remember(
    String author,
    String text,
  ) => caller.callServerEndpoint<_i6ww7ycq.Memory>(
    'memory',
    'remember',
    {
      'author': author,
      'text': text,
    },
  );

  /// Returns all memories saved in the database, most recent first.
  _ida.Future<List<_i6ww7ycq.Memory>> getMemories() =>
      caller.callServerEndpoint<List<_i6ww7ycq.Memory>>(
        'memory',
        'getMemories',
        {},
      );

  /// Deletes a memory by id.
  _ida.Future<void> forget(int id) => caller.callServerEndpoint<void>(
    'memory',
    'forget',
    {'id': id},
  );
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    agent = EndpointAgent(this);
    greeting = EndpointGreeting(this);
    memory = EndpointMemory(this);
  }

  late final EndpointAgent agent;

  late final EndpointGreeting greeting;

  late final EndpointMemory memory;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'agent': agent,
    'greeting': greeting,
    'memory': memory,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {};
}
