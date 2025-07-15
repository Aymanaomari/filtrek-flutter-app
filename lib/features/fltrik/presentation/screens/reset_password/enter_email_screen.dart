import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterEmailScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAssets.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: ColorsAssets.scaffoldBackground,
        leading: BackButton(color: ColorsAssets.textLight),
      ),
      resizeToAvoidBottomInset: true, // Permet de remonter le bouton
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  24, 24, 24, 100), // espace en bas pour le bouton
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.email_outlined,
                      color: ColorsAssets.primaryColor, size: 40),
                  SizedBox(height: 20),
                  Text(
                    "Reset Password",
                    style: AppTypography.h2
                        .copyWith(color: ColorsAssets.textLight),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Enter the email associated with your account and we’ll send an email to reset your password",
                    style: AppTypography.body2
                        .copyWith(color: ColorsAssets.textMedium),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: emailController,
                    style: TextStyle(color: ColorsAssets.textLight),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,
                          color: ColorsAssets.primaryColor, size: 40),
                      labelText: "Email",
                      hintText: "Example@email.com",
                      hintStyle: TextStyle(color: ColorsAssets.textLightMedium),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorsAssets.textLightMedium),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorsAssets.primaryColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: AppButton(
                  onPressed: () {
                    context.push('/newPwd');
                  },
                  text: "Verify",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
