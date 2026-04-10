import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SubscribtionCard extends ConsumerWidget {
  const SubscribtionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userStateProvider);

    if (userState.isLoading) {
      // Show skeleton loader when loading
      return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: colors.secondary, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 24, width: 120, color: colors.outline.withOpacity(0.2)),
            SizedBox(height: 8),
            Container(
                height: 16, width: 80, color: colors.outline.withOpacity(0.2)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.outline.withOpacity(0.2))),
                  SizedBox(height: 4),
                  Container(
                      height: 16,
                      width: 80,
                      color: colors.outline.withOpacity(0.2)),
                  Container(
                      height: 12,
                      width: 60,
                      color: colors.outline.withOpacity(0.2)),
                ]),
                Column(children: [
                  Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.outline.withOpacity(0.2))),
                  SizedBox(height: 4),
                  Container(
                      height: 16,
                      width: 80,
                      color: colors.outline.withOpacity(0.2)),
                  Container(
                      height: 12,
                      width: 60,
                      color: colors.outline.withOpacity(0.2)),
                ])
              ],
            )
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(ImageAssets.homeSubscribtionCardBg),
            fit: BoxFit.cover,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userState.currentUserMembership?.gymName ?? "No Gym Selected",
              style: AppTypography.h3.copyWith(color: colors.primary)),
          Text(
            userState.currentUserMembership?.pack.name ?? "No Active Plan",
            style: AppTypography.caption.copyWith(color: colors.outline),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircularPercentIndicator(
                    radius: 35.0,
                    lineWidth: 7.0,
                    backgroundColor: colors.primary.withOpacity(0.2),
                    percent: userState.currentUserMembership != null
                        ? userState.currentUserMembership!.remainingPoints /
                            userState
                                .currentUserMembership!.pack.coachSessionsLimit
                        : 0.0,
                    center: Text(userState.currentUserMembership != null
                        ? "${userState.currentUserMembership!.remainingPoints} of ${userState.currentUserMembership!.pack.coachSessionsLimit}"
                        : "0 of 0"),
                    progressColor: colors.primary,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Remaining Coaching",
                      style: AppTypography.labelLarge.copyWith(
                          color: colors.onSecondary,
                          fontWeight: FontWeight.w600)),
                  Text(
                    "Sessions",
                    style: AppTypography.labelSmall
                        .copyWith(color: colors.outline),
                  )
                ],
              ),
              Column(
                children: [
                  CircularPercentIndicator(
                    radius: 35.0,
                    lineWidth: 7.0,
                    backgroundColor: colors.primary.withOpacity(0.2),
                    percent: userState.currentUserMembership!
                            .collective_remaining_points /
                        userState.currentUserMembership!.pack
                            .collectiveSessionsLimit,
                    center: Text(userState.currentUserMembership != null
                        ? "${userState.currentUserMembership!.collective_remaining_points} of ${userState.currentUserMembership!.pack.collectiveSessionsLimit}"
                        : "0 of 0"),
                    progressColor: colors.primary,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Remaining Collective",
                      style: AppTypography.labelLarge.copyWith(
                          color: colors.onSecondary,
                          fontWeight: FontWeight.w600)),
                  Text(
                    "Sessions",
                    style: AppTypography.labelSmall
                        .copyWith(color: colors.outline),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
