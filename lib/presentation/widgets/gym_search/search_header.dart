import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchHeader extends ConsumerStatefulWidget {
  const SearchHeader({super.key});

  @override
  ConsumerState<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends ConsumerState<SearchHeader> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final searchController =
        ref.read(searchScreenManagerProvider).searchController;
    searchController.addListener(_onSearchChanged);
    // Request focus on the search field after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _onSearchChanged() {
    ref.read(searchScreenManagerProvider.notifier).loadGyms();
  }

  @override
  void dispose() {
    final searchController =
        ref.read(searchScreenManagerProvider).searchController;
    searchController.removeListener(_onSearchChanged);
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.read(searchScreenManagerProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          SearchTextField(
            hintText: 'Search Here ...',
            keyboardType: TextInputType.text,
            controller: searchState.searchController,
            focusNode: _searchFocusNode,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
