import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/home/profile_picture.dart';
import 'package:filtrek_app/presentation/widgets/profile/remaining_score.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // Watch currentUser
    final userState = ref.watch(userStateProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Profile",
                style: AppTypography.h3.copyWith(color: colors.onSecondary),
              ),
              GestureDetector(
                onTap: () {
                  context.pushNamed(RouteNames.settings);
                },
                child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(999)),
                    child: Icon(
                      Icons.settings_outlined,
                      color: colors.onSecondary,
                    )),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            children: [
              ProfilePicture(
                height: 90,
                width: 90,
              ),
              SizedBox(
                height: 6,
              ),
              userState.isLoading
                  ? Container(
                      height: 20,
                      width: 120,
                      decoration: BoxDecoration(
                        color: colors.secondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )
                  : userState.errorMessage != null
                      ? Text(
                          'Error loading user',
                          style: AppTypography.bodyMedium
                              .copyWith(color: colors.error),
                        )
                      : Text(
                          userState.currentUser!.username.capitalize(),
                          style: AppTypography.h2
                              .copyWith(color: colors.onSecondary),
                        )
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(
                        "15",
                        style: AppTypography.h1
                            .copyWith(color: colors.onSecondary),
                      ),
                      Text(
                        "Coaching",
                        style: AppTypography.bodyMedium
                            .copyWith(color: colors.outline),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: colors.secondary,
                ),
                Expanded(
                  child: Column(
                    spacing: 8,
                    children: [
                      Text(
                        "11",
                        style: AppTypography.h1
                            .copyWith(color: colors.onSecondary),
                      ),
                      Text(
                        "Collective",
                        style: AppTypography.bodyMedium
                            .copyWith(color: colors.outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Sessions Overview",
            style: AppTypography.h3.copyWith(color: colors.onSecondary),
          ),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RemainingScore(
                  number: 15,
                  icon: Icons.local_fire_department,
                  text: "Remaining\ncoaching",
                ),
                RemainingScore(
                  number: 5,
                  icon: Icons.people,
                  text: "Remaining\nCollective",
                ),
                RemainingScore(
                  number: 15,
                  icon: Icons.calendar_today,
                  text: "Remaining\ncoaching",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
