import 'package:flutter/material.dart';

class CollectiveSessionListTileSkeleton extends StatelessWidget {
  const CollectiveSessionListTileSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outline.withOpacity(0.2)),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          title: Container(
            width: 120,
            height: 16,
            color: colors.outline.withOpacity(0.15),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Container(
                width: 60,
                height: 12,
                color: colors.outline.withOpacity(0.10),
              ),
              SizedBox(height: 4),
              Container(
                width: 80,
                height: 12,
                color: colors.outline.withOpacity(0.10),
              ),
            ],
          ),
          trailing: Icon(Icons.chevron_right,
              color: colors.outline.withOpacity(0.2), size: 28),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}
