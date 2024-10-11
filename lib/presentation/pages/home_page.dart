// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_blogapp_frontend/domain/entities/post_entites.dart';
import '../controllers/post_controller.dart';
import '../widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yazılar'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Hata: ${controller.errorMessage.value}'));
        }

        if (controller.posts.isEmpty) {
          return const Center(child: Text('Hiç yazı bulunamadı.'));
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final Post post = controller.posts[index];
            return PostCard(post: post);
          },
        );
      }),
    );
  }
}
