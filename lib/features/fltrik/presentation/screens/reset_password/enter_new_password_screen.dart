import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/password_changed_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/reset_password/Blurred_dialog_overlay.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterNewPasswordScreen extends StatelessWidget {
  final TextEditingController pass1 = TextEditingController();
  final TextEditingController pass2 = TextEditingController();

  EnterNewPasswordScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAssets.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: ColorsAssets.scaffoldBackground,
        leading: BackButton(color: ColorsAssets.textLight),
      ),
      resizeToAvoidBottomInset: true, // Important pour remonter le bouton
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  24, 24, 24, 100), // laisse l’espace pour le bouton
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
                  ),
                  SizedBox(height: 20),
                  AppPasswordTextField(
                    labelText: "Reenter password",
                    icon: Icons.lock_outline,
                  ),
                ],
              ),
            ),
            // Bouton en bas
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: AppButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          BlurredDialogOverlay(child: PasswordChangedScreen()),
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
