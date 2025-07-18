import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CustomTabs extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<String> onTabSelected;
  final String? initialTab;

  const CustomTabs({
    super.key,
    required this.tabs,
    required this.onTabSelected,
    this.initialTab,
  });

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  late String selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialTab ?? widget.tabs.first;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      scrollDirection: Axis.horizontal,
      children: widget.tabs.map((tab) {
        final bool isSelected = tab == selectedTab;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = tab;
            });
            widget.onTabSelected(tab);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              tab,
              style: AppTypography.button.copyWith(
                color: isSelected ? colors.surface : colors.outline,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
