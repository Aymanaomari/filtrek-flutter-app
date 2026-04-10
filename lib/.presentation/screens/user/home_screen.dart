import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/providers/managers/home/home_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/providers/notification_provider.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_text_field.dart';
import 'package:filtrek_app/presentation/widgets/home/custom_tabs.dart';
import 'package:filtrek_app/presentation/widgets/home/gym_card_item.dart';
import 'package:filtrek_app/presentation/widgets/home/gym_card_skeleton.dart';
import 'package:filtrek_app/presentation/widgets/home/notification_button.dart';
import 'package:filtrek_app/presentation/widgets/home/profile_picture.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    // Watch the home screen state
    final homeState = ref.watch(homeScreenManagerProvider);
    final homeNotifier = ref.read(homeScreenManagerProvider.notifier);

    // Watch currentUser
    final userState = ref.watch(userStateProvider);

    final notificationState = ref.watch(notificationProvider);

    return RefreshIndicator(
        onRefresh: () async {
          await homeNotifier.reloadData();
        },
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 30.0.hp(context).clamp(280, 320),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.homeBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                context.replaceNamed(
                                    RouteNames.notificationScreen);
                              },
                              child: NotificationButton())
                        ],
                      ),
                      Spacer(),
                      Text(
                        "Find Your Perfect Gym",
                        style: AppTypography.h2.copyWith(color: colors.primary),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SearchTextField(
                        hintText: 'Search For a gym',
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        onTap: () {
                          context.pushNamed(RouteNames.searchScreen);
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 18,
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                SizedBox(
                    height: 32,
                    child: CustomTabs(
                      tabs: [
                        "Top Gyms",
                        "Nerby Gyms",
                      ],
                      initialTab: "Top Gyms",
                      onTabSelected: (name) {
                        print(name);
                      },
                    )),
                SizedBox(
                  height: 24,
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Top Gyms",
                //         style: AppTypography.h3
                //             .copyWith(color: colors.onSecondary),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           context.replaceNamed(RouteNames.searchScreen);
                //         },
                //         child: Text(
                //           "see all",
                //           style: AppTypography.body1
                //               .copyWith(color: colors.primary),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                  height:
                      208, // Set this to the height you want for your gym cards
                  child: homeState.isLoadingTopGyms
                      ? ListView(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          children: [
                            GymCardSkeleton(),
                            SizedBox(width: 8),
                            GymCardSkeleton(),
                            SizedBox(width: 8),
                            GymCardSkeleton(),
                            SizedBox(width: 8),
                          ],
                        )
                      : homeState.topGyms != null &&
                              homeState.topGyms!.data.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              itemCount: homeState.topGyms!.data.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final gym = homeState.topGyms!.data[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                        RouteNames.singleGymScreen,
                                        queryParameters: {"gymId": gym.id});
                                  },
                                  child: GymCardItem(gym: gym),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                homeState.topGymsError ?? "No gyms available",
                                style: AppTypography.body2.copyWith(
                                  color: colors.outline,
                                ),
                              ),
                            ),
                ),
                SizedBox(
                  height: 24,
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Popular exercices",
                //         style: AppTypography.h3
                //             .copyWith(color: colors.onSecondary),
                //       ),
                //       Text(
                //         "see all",
                //         style:
                //             AppTypography.body1.copyWith(color: colors.primary),
                //       )
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ));
  }
}
