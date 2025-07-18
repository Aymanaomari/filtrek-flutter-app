import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/filter_button.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_header.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_result_content.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/search_result_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GymSearchScreen extends ConsumerStatefulWidget {
  const GymSearchScreen({super.key});

  @override
  ConsumerState<GymSearchScreen> createState() => _GymSearchScreenState();
}

class _GymSearchScreenState extends ConsumerState<GymSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchNotifier = ref.read(searchScreenManagerProvider.notifier);

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            await searchNotifier.loadGyms();
          },
          child: ListView(
            children: [
              SearchHeader(),
              SearchResultsHeader(),
              SizedBox(
                height: 12,
              ),
              SearchResultsContent(),
            ],
          ),
        ),
        FilterButton(),
      ],
    );
  }
}
