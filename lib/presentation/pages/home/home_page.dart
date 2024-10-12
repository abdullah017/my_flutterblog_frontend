// lib/presentation/pages/home_page.dart
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_blogapp_frontend/presentation/controllers/post_controller/post_controller.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';
import 'package:my_blogapp_frontend/presentation/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  final PostController controller = Get.find<PostController>();
  final ThemeController themeController = Get.find<ThemeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temaya göre uygun renkleri al
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        iconTheme: theme.appBarTheme.iconTheme,
        title: isDarkMode
            ? Image.asset(
                'assets/abdullahtas_dark.png',
                height: 40,
              )
            : Image.asset(
                'assets/abdullahtas_LOGO.png',
                height: 40,
              ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.logo_github),
            color: theme.iconTheme.color,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.logo_twitter),
            color: theme.iconTheme.color,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.logo_instagram),
            color: theme.iconTheme.color,
          ),
          IconButton(
            onPressed: () {
              themeController.switchTheme();
            },
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: theme.iconTheme.color,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Başlık Bölümü
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Flutter...',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'Dart...',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'Hasura...',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'GraphQL...',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TyperAnimatedText(
                      'Firebase...',
                      textStyle: theme.textTheme.headlineMedium?.copyWith(
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Card(
                  color: theme.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Obx(() => TextField(
                            onChanged: (value) {
                              controller.searchTerm.value = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Makale ara...',
                              prefixIcon: Icon(Icons.search,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.grey.shade700),
                              suffixIcon: controller.searchTerm.value.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.grey.shade700),
                                      onPressed: () {
                                        controller.searchTerm.value = '';
                                      },
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: isDarkMode
                                      ? Colors.grey.shade700
                                      : Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: isDarkMode
                                      ? Colors.grey.shade700
                                      : Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: isDarkMode
                                      ? Colors.blueAccent
                                      : Colors.blue,
                                ),
                              ),
                              filled: true,
                              fillColor: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                            ),
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Yazı Listesi
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 200.0),
            sliver: Obx(() {
              if (controller.isLoading.value) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.filteredPosts.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Hiç yazı bulunamadı.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 18.0,
                      ),
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
                    return Container(
                        width: 500,
                        height: 340,
                        child: PostCard(post: controller.filteredPosts[index]));
                  },
                  staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                ),
              );
            }),
          ),
          // Alt Boşluk (Opsiyonel)
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(child: Container()),
          ),
        ],
      ),
    );
  }
}
