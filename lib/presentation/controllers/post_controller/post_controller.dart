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

  // All posts fetched from the backend
  var allPosts = <Post>[].obs;

  // Filtered posts based on the search term
  var filteredPosts = <Post>[].obs;

  // Search term entered by the user
  var searchTerm = ''.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedPost = Rxn<Post>();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    //Search
    everAll([allPosts, searchTerm], (_) => filterPosts());
    // debounce(searchTerm, (_) => filterPosts(),
    //     time: const Duration(milliseconds: 300));
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    final Either<Failure, List<Post>> result = await getPosts.call();
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (fetchedPosts) {
        allPosts.value = fetchedPosts;
      },
    );
    isLoading.value = false;
  }

  void filterPosts() {
    if (searchTerm.value.isEmpty) {
      filteredPosts.value = allPosts;
    } else {
      final query = searchTerm.value.toLowerCase();
      filteredPosts.value = allPosts.where((post) {
        return post.title.toLowerCase().contains(query);
      }).toList();
    }
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
