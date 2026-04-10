import 'package:filtrek_app/presentation/providers/managers/single_gym/single_gym_screen_provider.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_details_skeleton.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_header_section.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_tabbar_section.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_details_tab.dart';
import 'package:filtrek_app/presentation/widgets/single_gym/single_gym_location_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleGymScreen extends ConsumerStatefulWidget {
  final String gymId;

  const SingleGymScreen({super.key, required this.gymId});

  @override
  ConsumerState<SingleGymScreen> createState() => _SingleGymScreenState();
}

class _SingleGymScreenState extends ConsumerState<SingleGymScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Initialize tab controller after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(singleGymScreenProvider(widget.gymId).notifier);
      notifier.initializeTabController(this);
    });
  }

  @override
  void dispose() {
    // The autoDispose will handle disposal automatically
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gymState = ref.watch(singleGymScreenProvider(widget.gymId));
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          // Main content that can be scrolled behind the draggable sheet
          ListView(
            children: [
              SingleGymHeaderSection(
                isLoading: gymState.isLoading,
                gymData: gymState.data,
                onMenuPressed: () {
                  // Handle menu action
                },
              ),
            ],
          ),

          // Draggable bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.7,
            snap: true,
            snapSizes: const [0.5, 0.7],
            builder: (context, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  return true;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Drag handle - make it larger for better touch target
                      GestureDetector(
                        onTap: () {
                          // Optional: tap to toggle between min/max sizes
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Tab content
                      SingleGymTabBarSection(
                        tabController: gymState.tabController,
                        colors: colors,
                      ),
                      // TabBarView content
                      if (gymState.tabController != null)
                        Expanded(
                          child: TabBarView(
                            controller: gymState.tabController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              // Detail tab content
                              gymState.isLoading
                                  ? SingleGymDetailsSkeleton(
                                      colors: colors,
                                      scrollController: scrollController)
                                  : SingleGymDetailsTab(
                                      gymData: gymState.data!,
                                      colors: colors,
                                      scrollController: scrollController,
                                    ),
                              // Location tab content
                              SingleGymLocationTab(
                                gymData: gymState.data,
                                colors: colors,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
