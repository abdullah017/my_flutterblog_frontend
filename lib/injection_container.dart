// lib/injection_container.dart
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_blogapp_frontend/domain/repositories/post_repositories.dart';
import 'package:my_blogapp_frontend/domain/usecases/get_post_by_id_usecase.dart';
import 'package:my_blogapp_frontend/domain/usecases/get_post_usecase.dart';
import 'package:my_blogapp_frontend/presentation/controllers/post_controller.dart';
import 'graphql/graphql_client.dart';
import 'data/datasources/post_remote_data_source.dart';
import 'data/repositories/post_repository_impl.dart';

Future<void> init() async {
  // GraphQL Client
  final GraphQLClient client = GraphQLService.getClient().value;
  Get.lazyPut<GraphQLClient>(() => client);

  // Data Sources
  Get.lazyPut<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: Get.find<GraphQLClient>()));

  // Repositories
  Get.lazyPut<PostRepository>(() =>
      PostRepositoryImpl(remoteDataSource: Get.find<PostRemoteDataSource>()));

  // Use Cases
  Get.lazyPut(() => GetPosts(Get.find<PostRepository>()));
  Get.lazyPut(() => GetPostById(Get.find<PostRepository>()));

  // Controllers
  Get.lazyPut<PostController>(() => PostController(
        getPosts: Get.find<GetPosts>(),
        getPostById: Get.find<GetPostById>(),
      ));
}
