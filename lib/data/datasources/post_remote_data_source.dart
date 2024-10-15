// lib/data/datasources/post_remote_data_source.dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_blogapp_frontend/graphql/queries.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel?> getPostById(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final GraphQLClient client;

  PostRemoteDataSourceImpl({required this.client});

/// This function retrieves a list of posts from a server and maps them to a list of PostModel objects.
/// 
/// Returns:
///   A Future that resolves to a List of PostModel objects.
  @override
  Future<List<PostModel>> getPosts() async {
    final QueryOptions options = QueryOptions(
      document: gql(GET_POSTS),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw const ServerException();
    }

    final List<dynamic> postsJson = result.data?['posts'] ?? [];
    return postsJson.map((json) => PostModel.fromJson(json)).toList();
  }

/// This Dart function retrieves a post by its ID using GraphQL and returns a PostModel object.
/// 
/// Args:
///   id (int): The `getPostById` method you provided is used to fetch a post by its ID from a GraphQL
/// server. The `id` parameter is the unique identifier of the post you want to retrieve. This method
/// sends a query to the server with the specified ID and returns the corresponding `PostModel` object
/// 
/// Returns:
///   The `getPostById` method is returning a `Future` that resolves to a `PostModel` object or `null`
/// if the `postJson` is null.
  @override
  Future<PostModel?> getPostById(int id) async {
    final QueryOptions options = QueryOptions(
      document: gql(GET_POST_BY_ID),
      variables: {'id': id},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw const ServerException();
    }

    final dynamic postJson = result.data?['posts_by_pk'];
    if (postJson == null) return null;

    return PostModel.fromJson(postJson);
  }
}
