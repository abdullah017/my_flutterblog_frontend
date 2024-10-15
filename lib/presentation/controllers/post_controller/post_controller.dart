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

  /// These lines of code are defining reactive variables using GetX library in Dart. Here's what each
  /// variable is doing:
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
  }

  /// The `fetchPosts` function fetches posts asynchronously, updates state based on the result, and
  /// handles potential errors.
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

  /// The function `filterPosts` filters a list of posts based on a search term provided by the user.
  ///
  /// Returns:
  ///   The `filterPosts()` function returns a list of posts that contain the search term in their title.
  /// If the search term is empty, it returns all posts.
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

  /// This function fetches a post by its ID, updates the UI with the fetched post or error message, and
  /// manages a loading state.
  ///
  /// Args:
  ///   id (int): The `id` parameter in the `fetchPostById` function represents the unique identifier of
  /// the post that you want to fetch. This function is responsible for fetching a post by its ID
  /// asynchronously.
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
