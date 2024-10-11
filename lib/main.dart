// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:my_blogapp_frontend/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter(); // Hive için gerekli başlatma işlemi
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
          title: 'Frontend',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
