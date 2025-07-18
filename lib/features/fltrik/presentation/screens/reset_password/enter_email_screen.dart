import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/presentation/providers/reset-password/EnterEmailScreenProvider.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EnterEmailScreen extends ConsumerWidget {
  const EnterEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(enterEmailScreenProvider);
    final notifier = ref.read(enterEmailScreenProvider.notifier);

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
                  Form(
                    key: state.formKey,
                    child: AppTextField(
                      controller: state.emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Example@email.com",
                      errorText: state.errorText, // ✅ affichage d'erreur
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
                    final isValid = notifier.validateEmail();
                    if (isValid) {
                      context.push('/newPwd');
                    }
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
