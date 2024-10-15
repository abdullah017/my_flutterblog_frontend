import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final bool isDarkMode = themeController.isDarkMode;

    // Responsive tasarım için ekran genişliğini alıyoruz
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: HomePageHeaderWidget(
        theme: theme,
        isDarkMode: isDarkMode,
        themeController: themeController,
        isMobile: isMobile,
      ),
      drawer: isMobile ? _buildDrawer(theme, isDarkMode) : null,
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

  // Drawer menüsünü Scaffold içinde oluşturma
  Widget _buildDrawer(ThemeData theme, bool isDarkMode) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: Text(
              appTitle,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: theme.iconTheme.color),
            title: Text(
              home,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.article, color: theme.iconTheme.color),
            title: Text(
              blog,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.contact_mail, color: theme.iconTheme.color),
            title: Text(
              contact,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
              leading: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: theme.iconTheme.color,
              ),
              title: Text(
                'Tema Değiştir',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
              trailing: Switch(
                value: themeController.isDarkMode,
                onChanged: (value) {
                  themeController.switchTheme();
                },
                activeColor: theme.colorScheme.primary,
                inactiveThumbColor: Colors.grey,
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Icon(Icons.dark_mode, color: Colors.white);
                    }
                    return const Icon(Icons.light_mode, color: Colors.white);
                  },
                ),
              )),
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
          padding: kIsWeb
              ? const EdgeInsets.symmetric(horizontal: 150.0)
              : const EdgeInsets.symmetric(horizontal: 20.0),
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
