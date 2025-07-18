import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/authentication/presentation/providers/login_screen_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpSection extends ConsumerWidget {
  const SignUpSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final loginScreenManagerNotifier =
        ref.read(loginScreenManagerProvider.notifier);

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
          onTap: () =>
              loginScreenManagerNotifier.navigateToSignupScreen(context),
        ),
      ],
    );
  }
}
