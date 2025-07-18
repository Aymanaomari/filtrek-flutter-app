import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/filter_button.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_header.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_result_content.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_result_header.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool _showSearchField = true;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(_handleSearchFocusChange);
    // Request focus on init
    Future.delayed(Duration.zero, () {
      if (mounted) _searchFocusNode.requestFocus();
    });
  }

  void _handleSearchFocusChange() {
    if (!_searchFocusNode.hasFocus && _showSearchField) {
      setState(() {
        _showSearchField = false;
      });
    }
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_handleSearchFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchNotifier = ref.read(searchScreenManagerProvider.notifier);
    final searchState = ref.watch(searchScreenManagerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _showSearchField
              ? SearchTextField(
                  hintText: 'Search Text Field',
                  keyboardType: TextInputType.text,
                  focusNode: _searchFocusNode,
                  controller: searchState.searchController,
                  onChanged: (value) {
                    searchNotifier.loadGyms();
                  },
                )
              : const Text("Search"),
        ),
        actions: [
          if (!_showSearchField)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _showSearchField = true;
                  // Request focus when showing the field
                  Future.delayed(Duration.zero, () {
                    _searchFocusNode.requestFocus();
                  });
                });
              },
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                if (!mounted) return;
                await searchNotifier.loadGyms();
              },
              child: ListView(
                children: [
                  SearchResultsHeader(),
                  const SizedBox(height: 12),
                  SearchResultsContent(),
                ],
              ),
            ),
            FilterButton(),
          ],
        ),
      ),
    );
  }
}
