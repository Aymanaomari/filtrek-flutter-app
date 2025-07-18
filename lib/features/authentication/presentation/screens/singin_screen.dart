import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/forgot_password_section.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/google_login_section.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/login_button.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/login_form.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/login_header.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/or_devider_secction.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/singup_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninScreen extends ConsumerStatefulWidget {
  static const String routeName = '/signin';
  static const String routePath = '/signin';

  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LoginHeader(),
                  SizedBox(height: 15.0.hp(context).clamp(60, 80)),
                  LoginForm(),
                  const ForgotPasswordSection(),
                  const SizedBox(height: 16),
                  LoginButton(),
                  const SizedBox(height: 32),
                  const OrDividerSection(),
                  const SizedBox(height: 24),
                  GoogleLoginSection(),
                  const SizedBox(height: 24),
                  SignUpSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
