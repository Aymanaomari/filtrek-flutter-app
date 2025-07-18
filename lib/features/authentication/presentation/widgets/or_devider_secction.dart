import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrDividerSection extends StatelessWidget {
  const OrDividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: color.outline,
            thickness: 1.0,
            endIndent: 8.0,
          ),
        ),
        Text(
          "OR - Sign in with",
          style: AppTypography.body1.copyWith(
            color: color.outlineVariant,
          ),
        ),
        Expanded(
          child: Divider(
            color: color.outline,
            thickness: 1.0,
            indent: 8.0,
          ),
        ),
      ],
    );
  }
}
