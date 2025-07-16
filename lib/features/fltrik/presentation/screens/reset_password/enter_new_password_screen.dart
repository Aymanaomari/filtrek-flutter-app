import 'dart:ui';

import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/screens/reset_password/password_changed_screen.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_password_text_field.dart';
import 'package:flutter/material.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  const EnterNewPasswordScreen({super.key});

  @override
  State<EnterNewPasswordScreen> createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  final TextEditingController pass1 = TextEditingController();
  final TextEditingController pass2 = TextEditingController();

  @override
  void dispose() {
    pass1.dispose();
    pass2.dispose();
    super.dispose();
  }

  void _onResetPassword() {
    final pwd1 = pass1.text.trim();
    final pwd2 = pass2.text.trim();

    if (pwd1.isEmpty || pwd2.isEmpty) {
      _showError("Both password fields are required.");
      return;
    }

    if (pwd1 != pwd2) {
      _showError("Passwords do not match.");
      return;
    }

    // Si les mots de passe sont valides et identiques
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          BlurredDialogOverlay(child: PasswordChangedScreen()),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      labelText: "New password", icon: Icons.lock_outline,controller: pass1),
                  SizedBox(height: 20),
                  AppPasswordTextField(
                      labelText: "Reenter password", icon: Icons.lock_outline,controller: pass2),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: AppButton(
                  onPressed: _onResetPassword,
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

class BlurredDialogOverlay extends StatelessWidget {
  final Widget child;

  const BlurredDialogOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Center(child: child),
      ],
    );
  }
}
