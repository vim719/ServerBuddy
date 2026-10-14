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
import '../agent/agent_endpoint.dart' as _i6aufbii;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../memories/memory_endpoint.dart' as _ievtq9uo;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'agent': _i6aufbii.AgentEndpoint()
        ..initialize(
          server,
          'agent',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'memory': _ievtq9uo.MemoryEndpoint()
        ..initialize(
          server,
          'memory',
          null,
        ),
    };
    connectors['agent'] = _is.EndpointConnector(
      name: 'agent',
      endpoint: endpoints['agent']!,
      methodConnectors: {
        'getConfig': _is.MethodConnector(
          name: 'getConfig',
          params: {
            'channel': _is.ParameterDescription(
              name: 'channel',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'uid': _is.ParameterDescription(
              name: 'uid',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i6aufbii.AgentEndpoint).getConfig(
                    session,
                    channel: params['channel'],
                    uid: params['uid'],
                  ),
        ),
        'startAgent': _is.MethodConnector(
          name: 'startAgent',
          params: {
            'channelName': _is.ParameterDescription(
              name: 'channelName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'agentUid': _is.ParameterDescription(
              name: 'agentUid',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userUid': _is.ParameterDescription(
              name: 'userUid',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'userKey': _is.ParameterDescription(
              name: 'userKey',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i6aufbii.AgentEndpoint).startAgent(
                    session,
                    params['channelName'],
                    params['agentUid'],
                    params['userUid'],
                    userKey: params['userKey'],
                  ),
        ),
        'stopAgent': _is.MethodConnector(
          name: 'stopAgent',
          params: {
            'agentId': _is.ParameterDescription(
              name: 'agentId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['agent'] as _i6aufbii.AgentEndpoint).stopAgent(
                    session,
                    params['agentId'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['memory'] = _is.EndpointConnector(
      name: 'memory',
      endpoint: endpoints['memory']!,
      methodConnectors: {
        'remember': _is.MethodConnector(
          name: 'remember',
          params: {
            'author': _is.ParameterDescription(
              name: 'author',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['memory'] as _ievtq9uo.MemoryEndpoint).remember(
                    session,
                    params['author'],
                    params['text'],
                  ),
        ),
        'getMemories': _is.MethodConnector(
          name: 'getMemories',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['memory'] as _ievtq9uo.MemoryEndpoint)
                  .getMemories(session),
        ),
        'forget': _is.MethodConnector(
          name: 'forget',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['memory'] as _ievtq9uo.MemoryEndpoint).forget(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
  }
}
