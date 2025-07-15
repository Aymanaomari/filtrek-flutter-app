import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/buildPasswordField.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterNewPasswordScreen extends StatelessWidget {
  final TextEditingController pass1 = TextEditingController();
  final TextEditingController pass2 = TextEditingController();

  EnterNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAssets.scaffoldBackground,
      appBar: AppBar(backgroundColor: ColorsAssets.scaffoldBackground, leading: BackButton(color: ColorsAssets.textLight)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lock_outline, color: ColorsAssets.primaryColor, size: 40),
            SizedBox(height: 20),
            Text("Enter New Password",style: AppTypography.h2.copyWith(color: ColorsAssets.textLight)),
            SizedBox(height: 10),
            Text("Enter a strong password you'll remember. Make sure it’s different from your previous ones.",
               style: AppTypography.body2.copyWith(color: ColorsAssets.textMedium)),
            SizedBox(height: 30),
            buildPasswordField(pass1),
            SizedBox(height: 20),
            buildPasswordField(pass2),
            SizedBox(height: 30),
            AppButton(onPressed: () {
                context.push('/validate');         
              },
            text: "Reset Password",
            backgroundColor: ColorsAssets.primaryColor,
            borderRadius: 10,)
          ],
        ),
      ),
    );
  }
}