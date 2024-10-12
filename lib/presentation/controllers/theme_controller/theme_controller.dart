// lib/controllers/theme_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  // GetStorage ile tema tercihini kalıcı hale getiriyoruz
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Varsayılan tema Light
  bool get isDarkMode => _box.read(_key) ?? false;

  // Tema değiştirme fonksiyonu
  void switchTheme() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    _box.write(_key, !isDarkMode);
  }

  @override
  void onInit() {
    super.onInit();
    // Uygulama başlatılırken temayı ayarla
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
