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
    required this.isMobile,
  });

  final ThemeData theme;
  final bool isDarkMode;
  final ThemeController themeController;
  final bool isMobile;

  // Menü seçeneklerini tanımlayan liste
  List<Widget> _buildMenuItems() {
    return [
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
          //Get.offAll(() => HomePage());
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
          //Get.to(() => BlogPage());
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
          //Get.to(() => ContactPage());
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: theme.appBarTheme.elevation,
      iconTheme: theme.appBarTheme.iconTheme,
      leadingWidth: isMobile ? null : Get.size.width * 0.1,
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu, color: theme.iconTheme.color),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            )
          : (isDarkMode
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
                )),
      title: isMobile
          ? const RepaintBoundary(
              child: Text(appTitle),
            )
          : RepaintBoundary(
              child: Row(
                children: _buildMenuItems(),
              ),
            ),
      actions: [
        Visibility(
          visible: isMobile ? false : true,
          child: Switch(
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
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
