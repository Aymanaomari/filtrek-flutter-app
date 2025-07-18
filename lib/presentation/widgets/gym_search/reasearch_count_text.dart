import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultsCountText extends ConsumerWidget {
  const ResultsCountText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.read(searchScreenManagerProvider);

    final colors = Theme.of(context).colorScheme;

    return searchState.isLoading
        ? const Text("Showing 0 gyms")
        : Text(
            "Showing ${searchState.total} gyms",
            style: AppTypography.body2.copyWith(color: colors.outline),
          );
  }
}
