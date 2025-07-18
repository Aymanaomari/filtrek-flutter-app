import 'package:filtrek_app/features/fltrik/core/constant/colors_assets.dart';
import 'package:filtrek_app/features/fltrik/core/constant/image_assets.dart';
import 'package:filtrek_app/features/fltrik/core/theme/app_typography.dart';
import 'package:filtrek_app/features/fltrik/core/utils/extensions.dart';
import 'package:filtrek_app/features/fltrik/presentation/providers/authentification/login_manager_provider.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_button.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_password_text_field.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/app_widgets/app_text_field.dart';
import 'package:filtrek_app/features/fltrik/presentation/widgets/authentification/o2auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginScreenManagerNotifier =
        ref.read(loginScreenManagerProvider.notifier);
    final loginScreenManagerState = ref.watch(loginScreenManagerProvider);

    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.logo,
                height: 40,
                width: 40,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Login",
                style: AppTypography.h1.copyWith(color: ColorsAssets.textLight),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Let’s sing in your Fitrek Account",
                style: AppTypography.subtitle2
                    .copyWith(color: ColorsAssets.textMedium),
              ),
              SizedBox(
                height: 15.0.hp(context).clamp(60, 80),
              ),
              Form(
                  key: loginScreenManagerState.formKey,
                  child: Column(
                    children: [
                      AppTextField(
                          controller: loginScreenManagerState.emailController,
                          hintText: "Enter your Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: ValidationBuilder()
                              .email("The Email is not valid")
                              .required()
                              .build(),
                          icon: Icons.email_outlined),
                      SizedBox(
                        height: 16,
                      ),
                      AppPasswordTextField(
                          controller:
                              loginScreenManagerState.passwordController,
                          hintText: "Enter your Password",
                          validator: ValidationBuilder()
                              .minLength(
                                  6, "Password must be at least 6 characters")
                              .required("Password is required")
                              .build(),
                          icon: Icons.lock_outline),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Text(
                      "Forget Password ?",
                      style: AppTypography.body2
                          .copyWith(color: ColorsAssets.primaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: AppButton(
                  text: "Get Started",
                  onPressed: () {
                    loginScreenManagerNotifier.login();
                  },
                  borderRadius: 100,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorsAssets.textMedium,
                      thickness: 1.0,
                      endIndent: 8.0, // Space between the line and the text
                    ),
                  ),
                  Text(
                    "OR",
                    style: AppTypography.body1.copyWith(
                      color: ColorsAssets.textLightMedium,
                      decoration: TextDecoration
                          .underline, // Adds underline to the text
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ColorsAssets.textMedium,
                      thickness: 1.0,
                      indent: 8.0, // Space between the text and the line
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: GoogleO2authButton(
                    borderRadius: 99,
                    onPressed: () {},
                  )),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppTypography.body2
                        .copyWith(color: ColorsAssets.textMedium),
                  ),
                  InkWell(
                    child: Text(
                      "Sign up",
                      style: AppTypography.body2
                          .copyWith(color: ColorsAssets.primaryColor),
                    ),
                    onTap: () => loginScreenManagerNotifier
                        .navigateToSignupScreen(context),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
