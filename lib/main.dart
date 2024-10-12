// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:my_blogapp_frontend/routes/app_pages.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await initHiveForFlutter(); 
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GraphQLClient client = Get.find<GraphQLClient>();

    return GraphQLProvider(
      client: ValueNotifier(client),
      child: CacheProvider(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Frontend',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          
        ),
      ),
    );
  }
}
