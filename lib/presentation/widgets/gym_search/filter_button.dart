import 'package:filtrek_app/presentation/widgets/gym_search/search_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 16,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              elevation: 12,
              context: context,
              builder: (modalContext) => Theme(
                data: Theme.of(context),
                child: const SearchFilterBottomSheet(),
              ),
            );
          },
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: Colors.black,
            size: 24,
          ),
          label: const Text(
            'Filter',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
            elevation: 4,
          ),
        ),
      ),
    );
  }
}
