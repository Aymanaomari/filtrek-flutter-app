import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/signup_button.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/signup_divider.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/signup_form.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/signup_google_button.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/signup_header.dart';
import 'package:filtrek_app/features/authentication/presentation/widgets/signup_login_redirect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  static const String routeName = '/signup';
  static const String routePath = '/signup';

  @override
  ConsumerState<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 40),
              SignupHeader(),
              SizedBox(height: 15.0.hp(context).clamp(60, 80)),
              SignupForm(),
              const SizedBox(height: 16),
              SignupButton(
                color: color,
              ),
              const SizedBox(height: 32),
              SignupDivider(),
              const SizedBox(height: 24),
              SignupGoogleButton(),
              const SizedBox(height: 24),
              SignupLoginRedirect(),
            ],
          ),
        ),
      ),
    );
  }
}
