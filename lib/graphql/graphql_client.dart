// lib/graphql/graphql_client.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';

class GraphQLService {
  static final HttpLink httpLink = HttpLink(
    graphqlEndpoint,
    defaultHeaders: {
      'x-hasura-admin-secret': hasuraAdminSecret,
    },
  );

  static final WebSocketLink websocketLink = WebSocketLink(
    webSocketLink,
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: {
        'headers': {
          'x-hasura-admin-secret': hasuraAdminSecret,
        },
      },
    ),
  );

  static Link getLink() {
    return Link.split(
      (request) => request.isSubscription,
      websocketLink,
      httpLink,
    );
  }

  static ValueNotifier<GraphQLClient> getClient() {
    return ValueNotifier(
      GraphQLClient(
        link: getLink(),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}
