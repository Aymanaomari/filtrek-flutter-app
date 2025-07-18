import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      children: [
        Image.asset(
          ImageAssets.logo,
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 8),
        Text(
          "Login",
          style: AppTypography.h1.copyWith(color: color.onSecondary),
        ),
        const SizedBox(height: 16),
        Text(
          "Let's sing in your Fitrek Account",
          style: AppTypography.subtitle2.copyWith(color: color.outline),
        ),
      ],
    );
  }
}
