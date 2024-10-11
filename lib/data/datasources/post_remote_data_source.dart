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
