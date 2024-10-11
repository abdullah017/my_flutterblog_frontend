// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_blogapp_frontend/presentation/controllers/post_controller.dart';
import 'package:my_blogapp_frontend/presentation/widgets/post_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  final PostController controller = Get.find<PostController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Uygulaması',
          style: GoogleFonts.lora(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          // Hoş Geldiniz Yazısı
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hoş Geldiniz!',
              style: GoogleFonts.lora(
                textStyle: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Yazı Listesi
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.posts.isEmpty) {
                return const Center(child: Text('Hiç yazı bulunamadı.'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: controller.posts.map((post) {
                    return StaggeredGridTile.fit(
                      crossAxisCellCount: 2,
                      child: PostCard(post: post),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
