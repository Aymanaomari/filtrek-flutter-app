import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/managers/search/search_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/grid_card_item.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/grid_card_skeleton.dart';
import 'package:filtrek_app/presentation/widgets/gym_search/list_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResultsContent extends ConsumerWidget {
  const SearchResultsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchScreenManagerProvider);
    final searchNotifier = ref.read(searchScreenManagerProvider.notifier);

    if (searchState.isLoading) {
      return const _LoadingGrid();
    } else if (searchState.errorMessage != null) {
      return _ErrorState(
        errorMessage: searchState.errorMessage!,
        onRetry: () => searchNotifier.loadGyms(),
      );
    } else if (searchState.data.isEmpty) {
      return const _EmptyState();
    } else {
      return searchState.showingStyle == "grid"
          ? _GridView(data: searchState.data)
          : _ListView(data: searchState.data);
    }
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const GridCardSkeleton();
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: colors.error),
            const SizedBox(height: 16),
            Text(
              'Error loading gyms',
              style: AppTypography.subtitle2.copyWith(color: colors.error),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: AppTypography.caption
                  .copyWith(color: colors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off, size: 48, color: colors.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              'No gyms found',
              style: AppTypography.subtitle2
                  .copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  final List data;

  const _GridView({required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 216),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final gym = data[index];
        return GridCardItem(gym: gym);
      },
    );
  }
}

class _ListView extends StatelessWidget {
  final List data;

  const _ListView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(
          data.length,
          (index) {
            final gym = data[index];
            return ListCardItem(gym: gym);
          },
        ),
      ),
    );
  }
}
