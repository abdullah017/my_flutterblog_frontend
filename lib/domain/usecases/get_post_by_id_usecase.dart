// lib/domain/usecases/get_post_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:my_blogapp_frontend/core/errors/failures.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import 'package:my_blogapp_frontend/domain/repositories/post_repositories.dart';

class GetPostById {
  final PostRepository repository;

  GetPostById(this.repository);

/// This function returns a Future that either contains a Failure or a Post object based on the id
/// provided.
/// 
/// Args:
///   id (int): The `id` parameter in the `call` method is an integer value that represents the unique
/// identifier of the post that you want to retrieve from the repository.
/// 
/// Returns:
///   The `call` method is returning a `Future` that resolves to an `Either` type. The `Either` type can
/// hold either a `Failure` object or a `Post` object. The method is asynchronous and it awaits the
/// result of calling `repository.getPostById(id)`.
  Future<Either<Failure, Post?>> call(int id) async {
    return await repository.getPostById(id);
  }
}
