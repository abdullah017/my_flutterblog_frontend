// lib/domain/repositories/post_repository.dart
import 'package:dartz/dartz.dart';
import 'package:my_blogapp_frontend/core/errors/failures.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';

/// The `PostRepository` class defines methods for retrieving lists of posts and individual posts by
/// their IDs.
abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post?>> getPostById(int id);
}
