import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tun_tun/app/data/reusable.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Aplikasi TunTun",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: customTheme(),
    );
  }
}

ThemeData customTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Reusable.textColor,
      surfaceTint: Colors.transparent,
      primary: Reusable.textColor,
      onSurface: Reusable.textColor,
    ),
    textTheme: GoogleFonts.kanitTextTheme().copyWith(
      titleMedium: TextStyle(
        color: Reusable.textColor,
      ),
    ),
  );
}
