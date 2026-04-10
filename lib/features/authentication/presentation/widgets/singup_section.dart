import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/signup_screen.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/singin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpSection extends ConsumerWidget {
  const SignUpSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          "Don't have an account?",
          style: AppTypography.body2.copyWith(color: color.outline),
        ),
        InkWell(
            child: Text(
              "Sign up",
              style: AppTypography.body2.copyWith(color: color.primary),
            ),
            onTap: () {
              context.pushNamed(SignupScreen.routeName);
            }),
      ],
    );
  }
}
