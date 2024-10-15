// lib/graphql/graphql_client.dart
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';

class GraphQLService {
/// The code snippet is defining a static final variable `httpLink` of type `HttpLink` in the
/// `GraphQLService` class. The `HttpLink` is being initialized with the `graphqlEndpoint` and a set of
/// default headers containing an 'x-hasura-admin-secret' key with the value of `hasuraAdminSecret`.
/// This `httpLink` will be used to establish an HTTP connection for making GraphQL requests to the
/// specified endpoint with the provided headers.
  static final HttpLink httpLink = HttpLink(
    graphqlEndpoint,
    defaultHeaders: {
      'x-hasura-admin-secret': hasuraAdminSecret,
    },
  );

/// The code snippet is defining a static final variable `websocketLink` of type `WebSocketLink` in the
/// `GraphQLService` class. This `websocketLink` is being initialized with a WebSocket connection to a
/// specified endpoint (`webSocketLink`) and a configuration object (`SocketClientConfig`).
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

/// The function `getLink()` returns a `Link` based on whether a request is a subscription or not, using
/// a `websocketLink` for subscription requests and an `httpLink` for non-subscription requests.
/// 
/// Returns:
///   A Link object is being returned. The Link object is created by splitting the request based on
/// whether it is a subscription request or not, and then combining the WebSocket link and HTTP link
/// accordingly.
  static Link getLink() {
    return Link.split(
      (request) => request.isSubscription,
      websocketLink,
      httpLink,
    );
  }

/// The function returns a ValueNotifier containing a GraphQLClient with a specified link and cache.
/// 
/// Returns:
///   A `ValueNotifier` containing a `GraphQLClient` instance is being returned. The `GraphQLClient` is
/// initialized with a link obtained from the `getLink()` function and a cache using `GraphQLCache` with
/// a `HiveStore`.
   static ValueNotifier<GraphQLClient> getClient() {
    return ValueNotifier(
      GraphQLClient(
        link: getLink(),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}
