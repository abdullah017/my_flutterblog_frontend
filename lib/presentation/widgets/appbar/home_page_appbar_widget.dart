import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
//import 'dart:html' as html; import 'dart:js' as js;

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
          onPressed: () {
            //canLaunchUrlString(githubLink);
            // kIsWeb
            //     ? js.context.callMethod('open',
            //         [githubLink]) //html.window.open(githubLink, 'new tab')
            //     : canLaunchUrlString(githubLink);
          },
          icon: const Icon(Ionicons.logo_github),
          color: theme.iconTheme.color,
        ),
        IconButton(
          onPressed: () {
            // canLaunchUrlString(twitterLink);
            // kIsWeb
            //     ? js.context.callMethod('open',
            //         [twitterLink]) //html.window.open(twitterLink, 'new tab')
            //     : canLaunchUrlString(twitterLink);
          },
          icon: const Icon(Ionicons.logo_twitter),
          color: theme.iconTheme.color,
        ),
        IconButton(
          onPressed: () {
            //  canLaunchUrlString(instagramLink);
            // kIsWeb
            //     ? js.context.callMethod('open', [
            //         instagramLink
            //       ]) //html.window.open(instagramLink, 'new tab')
            //     : canLaunchUrlString(instagramLink);
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
