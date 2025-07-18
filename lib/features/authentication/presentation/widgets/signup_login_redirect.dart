import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/features/authentication/presentation/screens/singin_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupLoginRedirect extends StatelessWidget {
  const SignupLoginRedirect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = ColorScheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          "Already have an account ?",
          style: AppTypography.body2.copyWith(color: color.outline),
        ),
        InkWell(
          onTap: () => context.goNamed(SigninScreen.routeName),
          child: Text(
            "Sign in",
            style: AppTypography.body2.copyWith(color: color.primary),
          ),
        ),
      ],
    );
  }
}
