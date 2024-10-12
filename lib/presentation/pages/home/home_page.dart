// lib/presentation/pages/home_page.dart
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_blogapp_frontend/presentation/controllers/post_controller/post_controller.dart';
import 'package:my_blogapp_frontend/presentation/widgets/post_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final PostController controller = Get.find<PostController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/abdullahtas_LOGO.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.logo_github)),
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.logo_twitter)),
          IconButton(
              onPressed: () {}, icon: const Icon(Ionicons.logo_instagram))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Başlık Bölümü

          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Flutter...',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'Dart...',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'Hasura...',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'GraphQL...',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'Firebase...',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ),
          ),

          // Search Bar Bölümü
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Card(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Obx(() => TextField(
                            onChanged: (value) {
                              controller.searchTerm.value = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'Makele ara...',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon:
                                    controller.searchTerm.value.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear),
                                            onPressed: () {
                                              controller.searchTerm.value = '';
                                            },
                                          )
                                        : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white),
                          )),
                    ),
                  ),
                ),
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

              if (controller.filteredPosts.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Hiç yazı bulunamadı.',
                    ),
                  ),
                );
              }
              // Web olup olmadığını kontrol et
              bool isWeb = kIsWeb;

              // Web ise genişliğe göre, değilse varsayılan olarak 2 kullan
              int crossAxisCount;

              if (isWeb) {
                double screenWidth = MediaQuery.of(context).size.width;
                crossAxisCount = screenWidth < 600 ? 2 : 4;
              } else {
                crossAxisCount = 2;
              }

              return SliverPadding(
                padding: const EdgeInsets.only(top: 20.0),
                sliver: SliverStaggeredGrid.countBuilder(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  itemCount: controller.filteredPosts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: controller.filteredPosts[index]);
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                ),
              );
            }),
          ),
          // Alt Boşluk (Optional)
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(child: Container()),
          ),
        ],
      ),
    );
  }
}
