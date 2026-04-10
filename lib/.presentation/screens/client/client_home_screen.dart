import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/client_home/client_home_screen_provider.dart';
import 'package:filtrek_app/presentation/providers/notification_provider.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/client_home/appointments_grid.dart';
import 'package:filtrek_app/presentation/widgets/client_home/appointments_grid_skeleton.dart';
import 'package:filtrek_app/presentation/widgets/client_home/collective_session_list_tile.dart';
import 'package:filtrek_app/presentation/widgets/client_home/collective_session_list_tile_skeleton.dart';
import 'package:filtrek_app/presentation/widgets/home/notification_button.dart';
import 'package:filtrek_app/presentation/widgets/home/profile_picture.dart';
import 'package:filtrek_app/presentation/widgets/home/subscribtion_card.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // Watch the home screen state

    // Watch currentUser
    final userState = ref.watch(userStateProvider);
    final userNotifier = ref.watch(userStateProvider.notifier);

    final clientHomeState = ref.watch(clientHomeScreenManagerProvider);
    final clientHomeNotifier =
        ref.watch(clientHomeScreenManagerProvider.notifier);

    final notificationState = ref.watch(notificationProvider);

    return RefreshIndicator(
        onRefresh: () async {
          clientHomeNotifier.loadData();
          userNotifier.refreshCurrentUser();
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.goNamed(RouteNames.profile);
                    },
                    child: ProfilePicture(
                      width: 48,
                      height: 48,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Good morning",
                        style: AppTypography.caption
                            .copyWith(color: colors.outline),
                      ),
                      Text(
                        userState.isLoading
                            ? ""
                            : userState.currentUser!.username,
                        style: AppTypography.body1.copyWith(
                            color: colors.onSecondary,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        context.goNamed(RouteNames.clientNotification);
                      },
                      child: NotificationButton())
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SubscribtionCard(),
            SizedBox(
              height: 24,
            ),
            // ...existing code...
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Workouts",
                        style: AppTypography.h3
                            .copyWith(color: colors.onSecondary),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(RouteNames.clientPlanScreen);
                        },
                        child: Text(
                          "See your plan",
                          style: AppTypography.body2
                              .copyWith(color: colors.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  clientHomeState.isLoading
                      ? AppointmentsGridSkeleton()
                      : AppointmentsGrid(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Events",
                        style: AppTypography.h3
                            .copyWith(color: colors.onSecondary),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(RouteNames.clientPlanScreen);
                        },
                        child: Text(
                          "See all",
                          style: AppTypography.body2
                              .copyWith(color: colors.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      clientHomeState.isLoading
                          ? Column(
                              children: List.generate(
                                  3,
                                  (index) =>
                                      CollectiveSessionListTileSkeleton()),
                            )
                          : Column(
                              spacing: 8,
                              children: clientHomeState.recentCollectiveSessions
                                      ?.recentCollectiveSessions
                                      .map((session) =>
                                          CollectiveSessionListTile(
                                              session: session))
                                      .toList() ??
                                  [],
                            ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
