import 'package:get/get.dart';
import 'package:my_blogapp_frontend/presentation/pages/home/home_page.dart';
import 'package:my_blogapp_frontend/presentation/pages/post/post_detail_page.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;
  static const unkown = Routes.not_found;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: '${Routes.post_detail}/:title-:postId', // Add title as a parameter
      page: () => PostDetailPage(
        postId: int.parse(Get.parameters['postId']!), // Parse postId
        title: Get.parameters['title']!, // Get the title slug
      ),
    ),

    // GetPage(
    //   name: '${Routes.post_detail}/:postId', // Define a dynamic parameter
    //   page: () => PostDetailPage(
    //       postId: int.parse(
    //           Get.parameters['postId']!)), // Get the postId from parameters
    // ),
  ];
}
