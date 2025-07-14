import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/core/utils/extensions.dart';
import 'package:filtrek_app/features/fltrik/presentation/providers/test_provider.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final testState = ref.watch(testNotifierProvider);
                final testNotifier = ref.read(testNotifierProvider.notifier);
                return testState.when(
                  data: (test) => Column(
                    children: [
                      Text(
                        'Test Data: ${test.text}',
                        style: AppTypography.body1
                            .copyWith(color: ColorsAssets.primaryColor),
                      ),
                      Text("hello world",
                          style: TextStyle(color: ColorsAssets.primaryColor)),
                      ElevatedButton(
                        onPressed: () =>
                            testNotifier.postTestData({'text': 'New test'}),
                        child: Text('Post Data'),
                      ),
                      ElevatedButton(
                        onPressed: () => testNotifier.refresh(),
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: (error, stack) => Column(
                    children: [
                      Text('Error: $error'),
                      ElevatedButton(
                        onPressed: () => testNotifier.refresh(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
