import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/providers/reset-password/EnterNewPasswordScreenProvider.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_blurred_dialog.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button_two.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_password_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterNewPasswordScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(enterNewPasswordScreenProvider);
    final notifier = ref.read(enterNewPasswordScreenProvider.notifier);

    return Scaffold(
      backgroundColor: ColorsAssets.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: ColorsAssets.scaffoldBackground,
        leading: BackButton(color: ColorsAssets.textLight),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline,
                      color: ColorsAssets.primaryColor, size: 40),
                  SizedBox(height: 20),
                  Text(
                    "Enter New Password",
                    style: AppTypography.h2
                        .copyWith(color: ColorsAssets.textLight),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Enter a strong password you'll remember. Make sure it’s different from your previous ones.",
                    style: AppTypography.body2
                        .copyWith(color: ColorsAssets.textMedium),
                  ),
                  SizedBox(height: 30),
                  AppPasswordTextField(
                      labelText: "New password",
                      icon: Icons.lock_outline,
                      controller: provider.pass1),
                  SizedBox(height: 20),
                  AppPasswordTextField(
                      labelText: "Reenter password",
                      icon: Icons.lock_outline,
                      controller: provider.pass2),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: AppButton(
                  onPressed: () async {
                    await notifier.resetPassword();
                    await Future.delayed(const Duration(seconds: 1));
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AppBlurredDialog(
                        title: "Password Changed Successfully",
                        description:
                            "Your password has been updated. You can now log in with your new credentials.",
                        icon: Icons.check_circle,
                        actionButton: AppButtonTwo(
                          text: "Log In",
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    );
                  },
                  text: "Reset Password",
                  backgroundColor: ColorsAssets.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
