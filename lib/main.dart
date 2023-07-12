import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final dataC = Get.put(DatabaseController());
  final authC = Get.put(AuthController());
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
