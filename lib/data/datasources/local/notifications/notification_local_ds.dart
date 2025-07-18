import 'package:filtrek_app/core/constant/sp_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NotificationStatus { enabled, disabled }

class NotificationLocalDs {
  Future<void> enableNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          SpKeys.notificationStatus, NotificationStatus.enabled.name);
    } catch (e) {
      print('Error enabling notifications: $e');
    }
  }

  Future<void> disableNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          SpKeys.notificationStatus, NotificationStatus.disabled.name);
    } catch (e) {
      print('Error disabling notifications: $e');
    }
  }

  Future<NotificationStatus> getNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final statusString = prefs.getString(SpKeys.notificationStatus);
    if (statusString == NotificationStatus.enabled.name) {
      return NotificationStatus.enabled;
    } else {
      return NotificationStatus.disabled;
    }
  }
}
