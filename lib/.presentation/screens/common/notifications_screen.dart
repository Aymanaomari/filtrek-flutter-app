import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/providers/notification_provider.dart';
import 'package:filtrek_app/presentation/widgets/notification/notification_item.dart';
import 'package:filtrek_app/presentation/widgets/notification/notification_item_skeleton.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  Future<void> _refresh(BuildContext context, WidgetRef ref) async {
    await ref.read(notificationProvider.notifier).getAllNotifications();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);
    final notifications = notificationState.notifications.notifications;
    final colors = ColorScheme.of(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: RefreshIndicator(
          onRefresh: () => _refresh(context, ref),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: AppTypography.h3.copyWith(color: colors.onSecondary),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.goNamed(RouteNames.settings);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: colors.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: notificationState.isLoading
                    ? ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 8,
                        separatorBuilder: (_, __) => SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return NotificationItemSkeleton();
                        },
                      )
                    : notifications.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAssets.notificationBackground,
                                    width: 40.0.wp(context),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "You're all caught up!",
                                    style: AppTypography.h3
                                        .copyWith(color: colors.primary),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Stay focused and keep pushing we'll notify you when it's time to move!",
                                    style: AppTypography.body2
                                        .copyWith(color: colors.tertiary),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ],
                          )
                        : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final notification = notifications[index];
                              return NotificationItem(
                                  notification: notification);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
