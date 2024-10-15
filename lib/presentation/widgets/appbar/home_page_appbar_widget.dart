import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_blogapp_frontend/core/constant/constant.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';
import 'package:my_blogapp_frontend/presentation/widgets/hoverable_text_widget/hoverable_text_widget.dart';

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
      leadingWidth: Get.size.width * 0.1,
      leading: isDarkMode
          ? RepaintBoundary(
              child: Image.asset(
                darkLogo,
                height: 40,
              ),
            )
          : RepaintBoundary(
              child: Image.asset(
                lightLogo,
                height: 40,
              ),
            ),
      title: RepaintBoundary(
        child: Row(
          children: [
            HoverableText(
              text: 'Ana Sayfa',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              hoverStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary, // Hover rengi
                ),
              ),
              onTap: () {
                // "Ana Sayfa" tıklandığında yapılacak işlemler
                // Örneğin: Get.to(() => HomePage());
              },
            ),
            const SizedBox(width: 10),
            HoverableText(
              text: 'Blog',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              hoverStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary, // Hover rengi
                ),
              ),
              onTap: () {
                // "Blog" tıklandığında yapılacak işlemler
                // Örneğin: Get.to(() => BlogPage());
              },
            ),
            const SizedBox(width: 10),
            HoverableText(
              text: 'İletişim',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
              hoverStyle: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.primary, // Hover rengi
                ),
              ),
              onTap: () {
                // "İletişim" tıklandığında yapılacak işlemler
                // Örneğin: Get.to(() => ContactPage());
              },
            ),
          ],
        ),
      ),
      actions: [
        Switch(
            value: themeController.isDarkMode,
            onChanged: (value) {
              themeController.switchTheme();
            },
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveThumbColor: Colors.grey,
            thumbIcon: themeController.isDarkMode
                ? const WidgetStatePropertyAll(Icon(Icons.dark_mode))
                : const WidgetStatePropertyAll(Icon(Icons.light_mode)))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
