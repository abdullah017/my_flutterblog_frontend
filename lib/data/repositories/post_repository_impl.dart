import 'package:dartz/dartz.dart';
import 'package:my_blogapp_frontend/core/errors/exception.dart';
import 'package:my_blogapp_frontend/core/errors/failures.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import 'package:my_blogapp_frontend/domain/repositories/post_repositories.dart';
import '../datasources/post_remote_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

/// This function retrieves a list of posts from a remote data source and returns either a list of posts
/// or a server failure.
/// 
/// Returns:
///   The `getPosts` method is returning a `Future` that resolves to an `Either` object containing
/// either a `Failure` or a list of `Post` objects. In the `try` block, it attempts to fetch a list of
/// `PostModel` objects from the `remoteDataSource` and then returns a `Right` object containing the
/// fetched `remotePosts`. If a `ServerException
  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final List<PostModel> remotePosts = await remoteDataSource.getPosts();
      return Right(remotePosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
/// This function retrieves a post by its ID from a remote data source and handles exceptions by
/// returning either the post or a server failure.
/// 
/// Args:
///   id (int): The `id` parameter in the `getPostById` method is an integer value representing the
/// unique identifier of the post that you want to retrieve from the data source.
/// 
/// Returns:
///   Either a `Right` containing the `PostModel` fetched from the remote data source, or a `Left`
/// containing a `ServerFailure` if a `ServerException` occurs during the operation.

  @override
  Future<Either<Failure, Post?>> getPostById(int id) async {
    try {
      final PostModel? remotePost = await remoteDataSource.getPostById(id);
      return Right(remotePost);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
