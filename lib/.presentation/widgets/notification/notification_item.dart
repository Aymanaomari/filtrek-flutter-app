import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/data/models/notifications/all_notifications_model.dart';
import 'package:filtrek_app/domain/entities/notification/get_all_notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItem({super.key, required this.notification});

  String formatCreatedAt(String createdAt) {
    final date = DateTime.parse(createdAt);
    return timeago.format(date, locale: 'en_short');
  }

  Color getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.REMINDER:
        return const Color(0xFFD1F96B); // lime green
      case NotificationType.NEWS:
        return const Color(0xFF6BC9F9); // blue
      case NotificationType.EVENT:
        return const Color(0xFFF96B6B); // coral red
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: getTypeColor(notification.notificationType),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.notifications_outlined, color: Colors.white),
            height: 40,
            width: 40,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${notification.notificationType.name}'
                      .toLowerCase()
                      .capitalize(),
                  style: AppTypography.body1.copyWith(
                      color: colors.onSecondary, fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
                SizedBox(height: 4),
                Text(
                  "${notification.message}",
                  style: AppTypography.caption.copyWith(color: colors.tertiary),
                  maxLines: 3,
                )
              ],
            ),
          ),
          Text(
            formatCreatedAt(notification.createdAt),
            style: AppTypography.bodySmall.copyWith(
              color: colors.outline,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
