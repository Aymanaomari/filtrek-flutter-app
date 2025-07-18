import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewToggleButtons extends ConsumerWidget {
  const ViewToggleButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final searchState = ref.watch(searchScreenManagerProvider);
    final searchNotifier = ref.watch(searchScreenManagerProvider.notifier);
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            searchNotifier.setShowingStyle("grid");
          },
          child: Icon(
            Icons.grid_view,
            size: 24,
            color: searchState.showingStyle == "grid"
                ? colors.primary
                : colors.outline,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            searchNotifier.setShowingStyle("list");
          },
          child: Icon(
            Icons.table_rows_outlined,
            size: 24,
            color: searchState.showingStyle == "list"
                ? colors.primary
                : colors.outline,
          ),
        ),
      ],
    );
  }
}
