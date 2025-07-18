import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFcmService {
  static String? fcmToken;

  static Future<void> init() async {
    await Firebase.initializeApp();
    fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");
    // You can send this token to your backend here if needed
  }

  static void listenOnMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: ${message.data}");
      // Handle navigation or other logic here
    });
  }
}
