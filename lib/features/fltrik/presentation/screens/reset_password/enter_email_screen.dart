import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  String? errorText;

  bool isEmailValid(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  void verifyEmail() {
    final email = emailController.text.trim();
    if (isEmailValid(email)) {
      setState(() => errorText = null);
      context.push('/newPwd');
    } else {
      setState(() => errorText = "Please enter a valid email address");
    }
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
                  Icon(Icons.email_outlined,
                      color: ColorsAssets.primaryColor, size: 40),
                  const SizedBox(height: 20),
                  Text(
                    "Reset Password",
                    style: AppTypography.h2
                        .copyWith(color: ColorsAssets.textLight),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enter the email associated with your account and we’ll send an email to reset your password",
                    style: AppTypography.body2
                        .copyWith(color: ColorsAssets.textMedium),
                  ),
                  const SizedBox(height: 30),
                  AppTextField(
                    controller: emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Example@email.com",
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: AppButton(
                  onPressed: verifyEmail,
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
