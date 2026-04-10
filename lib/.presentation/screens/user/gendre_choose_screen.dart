import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/presentation/providers/user_provider.dart';
import 'package:filtrek_app/presentation/widgets/geneder_choose/gender_toggle_button.dart';
import 'package:filtrek_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GendreChooseScreen extends ConsumerWidget {
  const GendreChooseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userStateProvider);
    final userNotifier = ref.read(userStateProvider.notifier);
    String? selectedGender = userState.currentUser?.gender;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 64, bottom: 32),
        child: Column(
          children: [
            Text(
              "Tell us about yourself",
              style: AppTypography.h2.copyWith(color: colors.onSecondary),
            ),
            Text(
              "Select your gender to personalize your experience.",
              textAlign: TextAlign.center,
              style: AppTypography.body1.copyWith(color: colors.tertiary),
            ),
            Spacer(),
            GenderToggleButton(
              isSelected: selectedGender == "male",
              icon: Icons.male,
              text: "Male",
              onTap: () {
                userNotifier.updateGender("male");
              },
            ),
            SizedBox(
              height: 24,
            ),
            GenderToggleButton(
              isSelected: selectedGender == "female",
              icon: Icons.female,
              text: "Female",
              onTap: () {
                userNotifier.updateGender("female");
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  height: 48,
                  minWidth: 140,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                  onPressed: () {
                    context.pushNamed(RouteNames.ageChooseScreen);
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
                        Icons.navigate_next_outlined,
                        color: colors.surface,
                        size: 24,
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
