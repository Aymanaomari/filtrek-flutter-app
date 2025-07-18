import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  // handle background notification here
}

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    InitializationSettings settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse: (details) {},
    );

    // Request notification permission on Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void showBasicNotification({
    required int id,
    required String title,
    required String message,
  }) async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "basic_channel", // channel ID (must not be empty)
        "Basic Notification", // channel name
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      details,
    );
  }
}
