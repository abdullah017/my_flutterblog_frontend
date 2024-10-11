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

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final List<PostModel> remotePosts = await remoteDataSource.getPosts();
      return Right(remotePosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

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
