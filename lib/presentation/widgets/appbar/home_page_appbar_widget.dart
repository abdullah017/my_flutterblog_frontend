import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';

// TO DO

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
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(linkedinAppLink))) {
              await launchUrl(Uri.parse(linkedinAppLink),
                  mode: LaunchMode.externalApplication);
            } else if (await canLaunchUrl(Uri.parse(linkedinWebLink))) {
              await launchUrl(Uri.parse(linkedinWebLink),
                  mode: LaunchMode.externalApplication);
            } else {
              Get.snackbar('Hata', 'LinkedIn bağlantısı açılamadı.');
            }
          },
          icon: const Icon(Ionicons.logo_linkedin),
          color: theme.iconTheme.color,
        ),
        IconButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(githubAppLink))) {
              await launchUrl(Uri.parse(githubAppLink),
                  mode: LaunchMode.externalApplication);
            } else if (await canLaunchUrl(Uri.parse(githubWebLink))) {
              await launchUrl(Uri.parse(githubWebLink),
                  mode: LaunchMode.externalApplication);
            } else {
              Get.snackbar('Hata', 'Github bağlantısı açılamadı.');
            }
          },
          icon: const Icon(Ionicons.logo_github),
          color: theme.iconTheme.color,
        ),
        IconButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(twitterAppLink))) {
              await launchUrl(Uri.parse(twitterAppLink),
                  mode: LaunchMode.externalApplication);
            } else if (await canLaunchUrl(Uri.parse(twitterWebLink))) {
              await launchUrl(Uri.parse(twitterWebLink),
                  mode: LaunchMode.externalApplication);
            } else {
              Get.snackbar('Hata', 'X bağlantısı açılamadı.');
            }
          },
          icon: const Icon(Ionicons.logo_twitter),
          color: theme.iconTheme.color,
        ),
        IconButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(instagramAppLink))) {
              await launchUrl(Uri.parse(instagramAppLink),
                  mode: LaunchMode.externalApplication);
            } else if (await canLaunchUrl(Uri.parse(instagramWebLink))) {
              await launchUrl(Uri.parse(instagramWebLink),
                  mode: LaunchMode.externalApplication);
            } else {
              Get.snackbar('Hata', 'İnstagram bağlantısı açılamadı.');
            }
          },
          icon: const Icon(Ionicons.logo_instagram),
          color: theme.iconTheme.color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            onPressed: () {
              themeController.switchTheme();
            },
            icon: Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: theme.iconTheme.color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
