import 'package:filtrek_app/presentation/widgets/gym_search/reasearch_count_text.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/view_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultsHeader extends ConsumerWidget {
  const SearchResultsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ResultsCountText(),
          ViewToggleButtons(),
        ],
      ),
    );
  }
}
