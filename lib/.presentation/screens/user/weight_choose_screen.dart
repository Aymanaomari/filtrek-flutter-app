import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class WeightChooseScreen extends ConsumerWidget {
  const WeightChooseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userStateProvider);
    final userNotifier = ref.read(userStateProvider.notifier);

    double weight = userState.currentUser?.weight ?? 70.0;

    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 64, bottom: 32),
        child: Column(
          children: [
            Text(
              "What's your current weight?",
              style: AppTypography.h2.copyWith(color: colors.onSecondary),
            ),
            Text(
              "Your weight helps us tailor your fitness and nutrition plan.",
              textAlign: TextAlign.center,
              style: AppTypography.body1.copyWith(color: colors.tertiary),
            ),
            const Spacer(),
            SpinBox(
              min: 20,
              max: 250,
              value: weight,
              step: 0.5,
              decimals: 1,
              decoration: InputDecoration(
                fillColor: colors.secondary,
                filled: true,
                labelText: "Weight (kg)",
                labelStyle:
                    AppTypography.body1.copyWith(color: colors.onSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              onChanged: (value) {
                userNotifier.updateWeight(value);
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    height: 48,
                    minWidth: 48,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                    color: colors.secondary,
                    child: Icon(
                      Icons.arrow_back,
                      color: colors.onSecondary,
                      size: 16,
                    )),
                MaterialButton(
                  height: 48,
                  minWidth: 140,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                  onPressed: () async {
                    await userNotifier.updateCurrentUser();
                    context.pushNamed(RouteNames.welcome);
                  },
                  color: colors.primary,
                  child: Row(
                    children: [
                      Text(
                        "Next",
                        style: AppTypography.button
                            .copyWith(color: colors.surface),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: colors.surface,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
