import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(
      {var id = 0,
      required String title,
      required String body,
      required FlutterLocalNotificationsPlugin notificationsPlugin}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "custom_notif",
      "new_notif",
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var notif = NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.show(id, title, body, notif);
  }
}
