import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tun_tun/app/controllers/auth_controller.dart';
import 'package:tun_tun/app/controllers/database_controller.dart';
import 'package:tun_tun/app/data/reusable.dart';
import 'package:tun_tun/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import './app/controllers/custom_notif.dart';

import 'app/routes/app_pages.dart';

// Settings Up Notifications
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  "Pesan baru",
  "Notifikasi baru",
  description: "Ada notifikasi baru",
  importance: Importance.high,
  playSound: true,
);

// Just need to be there
Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

// Local plugin untuk notifikasi
final FlutterLocalNotificationsPlugin localPlugin =
    FlutterLocalNotificationsPlugin();

// Untuk memunculkan notifikasi saat aplikasi terbuka
StreamSubscription foregroundMessage() => FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification!;

        if (notification != null) {
          localPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ),
          );
        }
      },
    );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

// Meminta izin notifikasi
  if (!await Permission.notification.isGranted) {
    Permission.notification.request();
  }

  try {
    if (GetPlatform.isAndroid) {
      // menunggu apa ada pesan masuk
      RemoteMessage? message =
          await FirebaseMessaging.instance.getInitialMessage();

      // Membuat notif untuk foreground
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      if (message != null) {
        // hanya ala ala aja
        FirebaseMessaging.onBackgroundMessage(
          (message) => _backgroundHandler(message),
        );
      }

      await localPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      foregroundMessage();
    }
  } catch (e) {}
  CustomNotification.initialize(localPlugin);

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
