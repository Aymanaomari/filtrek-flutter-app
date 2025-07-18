import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:filtrek_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class GenderToggleButton extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const GenderToggleButton({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.0.wp(context).clamp(80, 140),
        height: 40.0.wp(context).clamp(80, 140),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.secondary,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? colors.surface : colors.onSecondary,
              size: 72,
            ),
            Text(
              text,
              style: AppTypography.caption.copyWith(
                color: isSelected ? colors.surface : colors.onSecondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
