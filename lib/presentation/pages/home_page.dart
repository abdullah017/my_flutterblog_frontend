// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_blogapp_frontend/presentation/controllers/post_controller.dart';
import 'package:my_blogapp_frontend/presentation/widgets/post_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final PostController controller = Get.find<PostController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Admin Panel',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const FlutterLogo(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.breakfast_dining_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.breakfast_dining_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.breakfast_dining_rounded),
          )
        ],
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Başlık Bölümü
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Blog',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // Yazı Listesi
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            sliver: Obx(() {
              if (controller.isLoading.value) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.posts.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(child: Text('Hiç yazı bulunamadı.')),
                );
              }

              return SliverStaggeredGrid.countBuilder(
                crossAxisCount: 4,
                mainAxisSpacing: 20, // Daha makul spacing
                crossAxisSpacing: 20, // Daha makul spacing
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: controller.posts[index]);
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              );
            }),
          ),
          // Alt Boşluk
          const SliverToBoxAdapter(
            child: SizedBox(height: 50),
          ),
        ],
      ),
    );
  }
}
