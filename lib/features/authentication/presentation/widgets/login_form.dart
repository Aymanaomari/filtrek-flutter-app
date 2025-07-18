import 'package:filtrek_app/features/authentication/presentation/providers/login_screen_manager_provider.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_password_text_field.dart';
import 'package:filtrek_app/presentation/widgets/app_widgets/app_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginScreenManagerState = ref.watch(loginScreenManagerProvider);

    return Form(
      key: loginScreenManagerState.formKey,
      child: Column(
        children: [
          AppPhoneTextField(
            controller: loginScreenManagerState.phoneController,
            hintText: "Enter your Phone Number",
            icon: Icons.phone_outlined,
            errorText: loginScreenManagerState.emailError
                ? loginScreenManagerState.errorMessage
                : null,
          ),
          const SizedBox(height: 16),
          AppPasswordTextField(
            controller: loginScreenManagerState.passwordController,
            labelText: "Enter your Password",
            validator: ValidationBuilder()
                .minLength(6, "Password must be at least 6 characters")
                .required("Password is required")
                .build(),
            icon: Icons.lock_outline,
            isError: loginScreenManagerState.passwordError,
            errorText: loginScreenManagerState.passwordError
                ? loginScreenManagerState.errorMessage
                : null,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
