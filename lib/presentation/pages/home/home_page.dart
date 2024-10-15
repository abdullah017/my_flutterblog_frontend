import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';
import 'package:my_blogapp_frontend/presentation/controllers/post_controller/post_controller.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';
import 'package:my_blogapp_frontend/presentation/widgets/appbar/home_page_appbar_widget.dart';
import 'package:my_blogapp_frontend/presentation/widgets/post_card_widget/post_card.dart';

class HomePage extends StatelessWidget {
  final PostController controller = Get.find<PostController>();
  final ThemeController themeController = Get.find<ThemeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temaya göre uygun renkleri bulma
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: HomePageHeaderWidget(
          theme: theme,
          isDarkMode: isDarkMode,
          themeController: themeController),
      body: CustomScrollView(
        slivers: [
          // Başlık Bölümü
          animatedTextKit(theme),

          // Search Bar Bölümü
          searchBar(theme, isDarkMode),

          // Yazı Listesi
          articleList(theme, context),
          // Alt Boşluk (Opsiyonel)
        ],
      ),
    );
  }

  SliverPadding animatedTextKit(ThemeData theme) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                animatedFlutter,
                textStyle: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TyperAnimatedText(
                animatedDart,
                textStyle: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TyperAnimatedText(
                animatedHasura,
                textStyle: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TyperAnimatedText(
                animatedGraphQL,
                textStyle: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TyperAnimatedText(
                animatedFirebase,
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
    );
  }

  SliverPadding searchBar(ThemeData theme, bool isDarkMode) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                        hintText: searchArticle,
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
                            color:
                                isDarkMode ? Colors.grey.shade700 : Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color:
                                isDarkMode ? Colors.grey.shade700 : Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: isDarkMode ? Colors.blueAccent : Colors.blue,
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
    );
  }

  SliverPadding articleList(ThemeData theme, BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                notFoundArticle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 18.0,
                ),
              ),
            ),
          );
        }

        // Responsive crossAxisCount
        double screenWidth = MediaQuery.of(context).size.width;
        int crossAxisCount;

        if (screenWidth < 600) {
          // Mobil cihazlar
          crossAxisCount = 1;
        } else if (screenWidth < 1200) {
          // Tabletler
          crossAxisCount = 2;
        } else {
          // Web ve geniş ekranlar
          crossAxisCount = 4;
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
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          ),
        );
      }),
    );
  }
}
