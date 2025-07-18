import 'package:flutter/material.dart';

class NotificationItemSkeleton extends StatelessWidget {
  const NotificationItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 40,
            width: 40,
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                color: colors.outline.withOpacity(0.2),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 16,
                  color: colors.outline.withOpacity(0.2),
                  margin: EdgeInsets.only(bottom: 8),
                ),
                Container(
                  width: double.infinity,
                  height: 14,
                  color: colors.outline.withOpacity(0.15),
                  margin: EdgeInsets.only(bottom: 4),
                ),
                Container(
                  width: 120,
                  height: 14,
                  color: colors.outline.withOpacity(0.15),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 14,
            color: colors.outline.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
