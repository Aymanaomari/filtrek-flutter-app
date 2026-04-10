import 'dart:ui';
import 'package:filtrek_app/core/constant/colors_assets.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class AppBlurredDialog extends StatelessWidget {
  final Widget? actionButton;
  final Widget? cancelButton;
  final String title;
  final String description;
  final IconData icon;

  const AppBlurredDialog({
    super.key,
    this.actionButton,
    this.cancelButton,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Center(
            child: Material(
          borderRadius: BorderRadius.circular(16),
          color: color.primary,
          child: Container(
            padding: EdgeInsets.all(24),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 400,
            child: Column(
              children: [
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x3314151A),
                      ),
                    ),
                    Icon(icon, size: 60, color: Colors.black),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  title,
                  style: AppTypography.h2.copyWith(color: color.surface),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: AppTypography.body1.copyWith(color: color.surface),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Row(
                  spacing: 8,
                  children: [
                    if (cancelButton != null) Expanded(child: cancelButton!),
                    if (actionButton != null) Expanded(child: actionButton!),
                  ],
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}
