import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:numberpicker/numberpicker.dart';

class AgechooseScreen extends ConsumerStatefulWidget {
  const AgechooseScreen({super.key});

  @override
  ConsumerState<AgechooseScreen> createState() => _AgechooseScreenState();
}

class _AgechooseScreenState extends ConsumerState<AgechooseScreen> {
  int selectedAge = 20;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userStateProvider);
    final userNotifier = ref.read(userStateProvider.notifier);
    final int age = userState.currentUser?.age ?? 20;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 64, bottom: 32),
        child: Column(
          children: [
            Text(
              "How old Are you ?",
              style: AppTypography.h2.copyWith(color: colors.onSecondary),
            ),
            Text(
              "This helps us customize your fitness journey based on your age.",
              textAlign: TextAlign.center,
              style: AppTypography.body1.copyWith(color: colors.tertiary),
            ),
            Spacer(),
            // ...existing code...
            Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                NumberPicker(
                  textStyle: AppTypography.bodyLarge
                      .copyWith(color: colors.outlineVariant, fontSize: 36),
                  selectedTextStyle: AppTypography.captionLarge
                      .copyWith(color: colors.onSecondary),
                  value: age,
                  minValue: 14,
                  itemHeight: 70,
                  maxValue: 80,
                  itemCount: 3,
                  onChanged: (value) {
                    userNotifier.updateAge(value);
                  },
                ),
                // Top line
                Positioned(
                  top: 70, // Adjust based on itemHeight
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    color: colors.primary, // Green line color
                  ),
                ),
                // Bottom line
                Positioned(
                  bottom: 70, // Adjust based on itemHeight
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    color: colors.primary, // Green line color
                  ),
                ),
              ],
            ),
            Spacer(),

            Spacer(),
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
                  onPressed: () {
                    context.pushNamed(RouteNames.weightChooseScreen);
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
