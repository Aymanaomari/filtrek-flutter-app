import 'package:filtrek_app/data/models/notifications/all_notifications_model.dart';

class NotificationEntity {
  final String id;
  final String message;
  final NotificationType notificationType;
  final String createdAt;

  NotificationEntity(
      {required this.id,
      required this.message,
      required this.notificationType,
      required this.createdAt});
}

class AllNotificationsEntity {
  final List<NotificationEntity> notifications;

  AllNotificationsEntity({required this.notifications});
}
