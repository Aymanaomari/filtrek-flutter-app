import 'package:flutter/material.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? leadingOverride;

  const SettingsListTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.leadingOverride,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      leading: leadingOverride ??
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
      title: Text(title,
          style: AppTypography.body2.copyWith(
            color: color.tertiary,
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(subtitle,
          style: AppTypography.caption.copyWith(color: color.outline)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
