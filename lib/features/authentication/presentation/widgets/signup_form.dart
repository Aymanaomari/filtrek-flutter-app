import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/signup_screen_manager_provider.dart';
import 'package:filtrek_app/features/shared/widgets/app_password_text_field.dart';
import 'package:filtrek_app/features/shared/widgets/app_phone_text_field.dart';
import 'package:filtrek_app/features/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class SignupForm extends ConsumerWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupManagerProvider);
    final color = ColorScheme.of(context);

    return Form(
      key: signupState.formKey,
      child: Column(
        children: [
          AppTextField(
            controller: signupState.usernameController,
            labelText: "Enter your full name",
            icon: Icons.person_2_outlined,
            validator: ValidationBuilder()
                .required("Full name is required")
                .minLength(5)
                .build(),
          ),
          const SizedBox(height: 16),
          AppPhoneTextField(
            controller: signupState.phoneController,
            hintText: "Enter your Phone Number",
            icon: Icons.phone_outlined,
            errorText: signupState.phoneNumberError,
          ),
          const SizedBox(height: 16),
          AppPasswordTextField(
            controller: signupState.passwordController,
            labelText: "Create a secure password",
            validator: ValidationBuilder()
                .minLength(8, "Password must be at least 8 characters long")
                .regExp(
                  RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~_.,;:\-]).{8,}'),
                  "Password must contain upper, lower case, number, and special character",
                )
                .required("Password is required")
                .build(),
            icon: Icons.lock_outline,
          ),
          const SizedBox(height: 16),
          if (signupState.errorMessage != null)
            Text(
              signupState.errorMessage!,
              textAlign: TextAlign.left,
              style: AppTypography.body2.copyWith(color: color.error),
            ),
        ],
      ),
    );
  }
}
