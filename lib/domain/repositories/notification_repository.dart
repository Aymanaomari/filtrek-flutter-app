import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';
import 'package:filtrek_app/data/datasources/local/notifications/notification_local_ds.dart';

abstract class NotificationRepository {
  Future<AllNotificationsEntity> fetchAll();
  Stream<NotificationEntity> listenNew();

  Future<void> enableNotifications();
  Future<void> disableNotifications();
  Future<NotificationStatus> getNotificationStatus();
  addFcmToken(String fcm);
}
