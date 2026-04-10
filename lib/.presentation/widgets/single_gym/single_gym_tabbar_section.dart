import 'package:flutter/material.dart';

class SingleGymTabBarSection extends StatelessWidget {
  final TabController? tabController;
  final ColorScheme colors;

  const SingleGymTabBarSection({
    Key? key,
    required this.tabController,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: tabController != null
          ? TabBar(
              controller: tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              tabs: const [
                Tab(text: "DETAILS"),
                Tab(text: "LOCATION"),
              ],
            )
          : const SizedBox(
              height: 50,
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
