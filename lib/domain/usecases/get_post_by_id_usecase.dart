// lib/domain/usecases/get_post_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:my_blogapp_frontend/core/errors/failures.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import 'package:my_blogapp_frontend/domain/repositories/post_repositories.dart';

class GetPostById {
  final PostRepository repository;

  GetPostById(this.repository);

  Future<Either<Failure, Post?>> call(int id) async {
    return await repository.getPostById(id);
  }
}
