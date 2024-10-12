// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:my_blogapp_frontend/core/theme/theme.dart';
import 'package:my_blogapp_frontend/presentation/controllers/theme_controller/theme_controller.dart';
import 'package:my_blogapp_frontend/presentation/pages/unkown/unkown_page.dart';
import 'package:my_blogapp_frontend/routes/app_pages.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await GetStorage.init();
  await initHiveForFlutter();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GraphQLClient client = Get.find<GraphQLClient>();
    final ThemeController themeController = Get.find<ThemeController>();

    return GraphQLProvider(
      client: ValueNotifier(client),
      child: CacheProvider(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'abdullahtas.dev',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode:
              themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          unknownRoute:
              GetPage(name: '/notfound', page: () => const NotFoundPage()),
        ),
      ),
    );
  }
}
