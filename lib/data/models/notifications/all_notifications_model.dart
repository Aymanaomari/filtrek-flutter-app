import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';

enum NotificationType {
  REMINDER,
  NEWS,
  EVENT,
}

NotificationType notificationTypeFromString(String? type) {
  switch (type) {
    case 'REMINDER':
      return NotificationType.REMINDER;
    case 'NEWS':
      return NotificationType.NEWS;
    case 'EVENT':
      return NotificationType.EVENT;
    default:
      throw ArgumentError('Unknown notification type: $type');
  }
}

class NotificationModel {
  final String id;
  final String message;
  final NotificationType type;
  final String state;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.message,
    required this.type,
    required this.state,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      message: json['message'] ?? '',
      type: notificationTypeFromString(json['type'] as String?),
      state: json['state'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      message: message,
      notificationType: type,
      createdAt: createdAt,
    );
  }
}

class AllNotificationsModel {
  final List<NotificationModel> notifications;

  AllNotificationsModel({required this.notifications});

  factory AllNotificationsModel.fromJson(Map<String, dynamic> json) {
    final notificationsList = json['data'] as List<dynamic>? ?? [];
    return AllNotificationsModel(
      notifications: notificationsList
          .map((item) =>
              NotificationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  AllNotificationsEntity toEntity() {
    return AllNotificationsEntity(
      notifications: notifications.map((model) => model.toEntity()).toList(),
    );
  }
}
