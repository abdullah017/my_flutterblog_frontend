// lib/presentation/pages/not_found_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Tema renklerine erişim
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sayfa Bulunamadı',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 404 İkonu
              Icon(
                Icons.error_outline,
                size: 100,
                color: isDarkMode ? Colors.redAccent : Colors.red,
              ),
              const SizedBox(height: 20),
              // Başlık
              Text(
                '404',
                style: GoogleFonts.lora(
                  textStyle: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Mesaj
              Text(
                'Aradığınız sayfa bulunamadı.',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Ana Sayfaya Dön Butonu
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed('/home'); // Ana sayfaya yönlendirir
                },
                icon: const Icon(Icons.home),
                label: Text(
                  'Ana Sayfaya Dön',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor:
                      isDarkMode ? Colors.white : Colors.white, // Buton rengi
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
