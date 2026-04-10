import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/choose_coach/choose_coach_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/coach_choosing/coach_card.dart';
import 'package:filtrek_app/presentation/widgets/coach_choosing/coach_grid_skeleton.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChooseCoachAppointmentScreen extends ConsumerStatefulWidget {
  const ChooseCoachAppointmentScreen({super.key});

  @override
  ConsumerState<ChooseCoachAppointmentScreen> createState() =>
      _ChooseCoachAppointmentScreenState();
}

class _ChooseCoachAppointmentScreenState
    extends ConsumerState<ChooseCoachAppointmentScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedTabIndex = 0;

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final chooseCoachScreenState = ref.watch(chooseCoachScreenManagerProvider);
    final chooseCoachScreenNotifier =
        ref.read(chooseCoachScreenManagerProvider.notifier);
    final tabLength = chooseCoachScreenState
            .availableCoachesEntity?.availableCoaches.keys.length ??
        1;

    tabController?.dispose();
    tabController = TabController(
        length: tabLength, vsync: this, initialIndex: selectedTabIndex);
    tabController!.addListener(() {
      if (tabController!.indexIsChanging) {
        setState(() {
          selectedTabIndex = tabController!.index;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
          // title: Text(
          //   "Appoitment",
          //   style: AppTypography.body1.copyWith(color: colors.onSecondary),
          // ),
          // centerTitle: true,
          ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available",
                    style: AppTypography.body1.copyWith(color: colors.tertiary),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Coaches",
                    style: AppTypography.h1.copyWith(color: colors.onSecondary),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (chooseCoachScreenState.isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (chooseCoachScreenState.availableCoachesEntity ==
                      null)
                    Center(child: Text("No coaches available"))
                  else
                    TabBar(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      isScrollable: true,
                      unselectedLabelColor: colors.outline,
                      tabAlignment: TabAlignment.start,
                      controller: tabController,
                      dividerColor: Colors.transparent,
                      tabs: chooseCoachScreenState
                          .availableCoachesEntity!.availableCoaches.keys
                          .map((key) => Tab(text: key))
                          .toList(),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.homeSubscribtionCardBg),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      colors.surface
                          .withOpacity(0.5), // Adjust opacity as needed
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: chooseCoachScreenState.isLoading
                    ? CoachGridSkeleton(itemCount: 6)
                    : chooseCoachScreenState.availableCoachesEntity == null
                        ? Center(child: Text("No coaches available"))
                        : TabBarView(
                            controller: tabController,
                            children: chooseCoachScreenState
                                .availableCoachesEntity!.availableCoaches.values
                                .map((coachList) => GridView.count(
                                      crossAxisCount: 2,
                                      padding: EdgeInsets.all(16),
                                      children: coachList
                                          .map((coachEntity) => CoachCard(
                                                coach: coachEntity,
                                                onTap: () {
                                                  chooseCoachScreenNotifier
                                                      .selectCoach(
                                                          coachEntity.coachId);
                                                },
                                                isSelected:
                                                    chooseCoachScreenState
                                                            .selectedCoachId ==
                                                        coachEntity.coachId,
                                              ))
                                          .toList(),
                                    ))
                                .toList(),
                          ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.all(16),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999)),
            onPressed: () {
              if (chooseCoachScreenState.selectedCoachId != null &&
                  (chooseCoachScreenState.selectedCoachId?.isNotEmpty ??
                      false)) {
                context.pushNamed(RouteNames.chooseTimeAppoiment,
                    queryParameters: {
                      'coachId': chooseCoachScreenState.selectedCoachId
                    });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please select a coach first."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            label: Text(
              "Pick a time",
              style: AppTypography.button,
            ),
          ),
        ),
      ),
    );
  }
}
