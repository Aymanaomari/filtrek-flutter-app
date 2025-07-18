import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class SignupDivider extends StatelessWidget {
  const SignupDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = ColorScheme.of(context);

    return Row(
      children: [
        Expanded(
          child: Divider(color: color.outline, thickness: 1.0, endIndent: 8.0),
        ),
        Text(
          "OR - Sign Up with",
          style: AppTypography.body1.copyWith(color: color.outline),
        ),
        Expanded(
          child: Divider(color: color.outline, thickness: 1.0, indent: 8.0),
        ),
      ],
    );
  }
}
