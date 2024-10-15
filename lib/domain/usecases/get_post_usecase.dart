// lib/domain/usecases/get_posts.dart
import 'package:dartz/dartz.dart';
import 'package:my_blogapp_frontend/core/errors/failures.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import 'package:my_blogapp_frontend/domain/repositories/post_repositories.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

/// This function returns a Future that either contains a list of posts or a failure object.
/// 
/// Returns:
///   A Future that will eventually resolve to an Either object containing either a Failure or a List of
/// Post objects.
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getPosts();
  }
}
