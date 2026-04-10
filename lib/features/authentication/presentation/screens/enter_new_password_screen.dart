import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/enter_new_password_screen_manager.dart';
import 'package:filtrek_app/features/shared/widgets/app_blurred_dialog.dart';
import 'package:filtrek_app/features/shared/widgets/app_button.dart';
import 'package:filtrek_app/features/shared/widgets/app_button_two.dart';
import 'package:filtrek_app/features/shared/widgets/app_password_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class EnterNewPasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = '/new-password';
  static const String routePath = '/new-password';

  const EnterNewPasswordScreen({super.key});

  @override
  ConsumerState<EnterNewPasswordScreen> createState() =>
      _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState
    extends ConsumerState<EnterNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(enterNewPasswordScreenProvider);
    final notifier = ref.read(enterNewPasswordScreenProvider.notifier);
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline, color: color.primary, size: 40),
                  const SizedBox(height: 20),
                  Text(
                    "Enter New Password",
                    style: AppTypography.h2.copyWith(color: color.onSecondary),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enter a strong password you'll remember. Make sure it’s different from your previous ones.",
                    style: AppTypography.body2.copyWith(color: color.outline),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: state.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppPasswordTextField(
                          controller: state.passwordTextController,
                          icon: Icons.lock_outline,
                          validator: ValidationBuilder()
                              .minLength(8,
                                  "Password must be at least 8 characters long")
                              .regExp(
                                RegExp(
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~_.,;:\-]).{8,}'),
                                "Password must contain upper, lower case, number, and special character",
                              )
                              .required("Password is required")
                              .build(),
                          errorText: state.error,
                          labelText: 'New password',
                        ),
                        const SizedBox(height: 20),
                        AppPasswordTextField(
                          controller: state.passwordConfirmController,
                          icon: Icons.lock_outline,
                          validator: ValidationBuilder()
                              .required("Value must not be null")
                              .build(),
                          errorText: state.error,
                          labelText: 'Renter password',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: AppButton(
                    onPressed: () async {
                      final success = await notifier.changePassowrd();
                      if (success) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AppBlurredDialog(
                            title: "Password Changed Successfully",
                            description:
                                "Your password has been updated. You can now log in with your new credentials.",
                            icon: Icons.check_circle,
                            actionButton: AppButtonTwo(
                                //TODO : Add navigation to login screen
                                text: "Log In",
                                onPressed: () => null
                                // context.goNamed(RouteNames.welcome),
                                ),
                          ),
                        );
                      }
                    },
                    text: "Reset Password",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
