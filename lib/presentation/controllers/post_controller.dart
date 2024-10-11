// lib/presentation/controllers/post_controller.dart
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:my_blogapp_frontend/core/errors/failures.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import 'package:my_blogapp_frontend/domain/usecases/get_post_by_id_usecase.dart';
import 'package:my_blogapp_frontend/domain/usecases/get_post_usecase.dart';

class PostController extends GetxController {
  final GetPosts getPosts;
  final GetPostById getPostById;

  PostController({
    required this.getPosts,
    required this.getPostById,
  });

  var posts = <Post>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedPost = Rxn<Post>();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    final Either<Failure, List<Post>> result = await getPosts.call();
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (fetchedPosts) {
        posts.value = fetchedPosts;
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchPostById(int id) async {
    isLoading.value = true;
    final Either<Failure, Post?> result = await getPostById.call(id);
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (post) {
        selectedPost.value = post;
      },
    );
    isLoading.value = false;
  }
}
