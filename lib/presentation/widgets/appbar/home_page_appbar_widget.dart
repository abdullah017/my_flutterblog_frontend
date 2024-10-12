import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';

class HomePageHeaderWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const HomePageHeaderWidget({
    super.key,
    required this.theme,
    required this.isDarkMode,
    required this.themeController,
  });

  final ThemeData theme;
  final bool isDarkMode;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: theme.appBarTheme.elevation,
      iconTheme: theme.appBarTheme.iconTheme,
      title: isDarkMode
          ? Image.asset(
              darkLogo,
              height: 40,
            )
          : Image.asset(
              lightLogo,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
