import 'package:filtrek_app/core/constant/image_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = ColorScheme.of(context);

    return Column(
      children: [
        Image.asset(ImageAssets.logo, height: 40, width: 40),
        const SizedBox(height: 8),
        Text(
          "Sign up",
          style: AppTypography.h1.copyWith(color: color.onSecondary),
        ),
        const SizedBox(height: 16),
        Text(
          "Let's create your Fitlek Account",
          style: AppTypography.subtitle2.copyWith(color: color.outline),
        ),
      ],
    );
  }
}
