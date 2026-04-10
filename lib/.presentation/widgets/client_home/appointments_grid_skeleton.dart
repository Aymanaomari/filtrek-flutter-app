import 'package:flutter/material.dart';
import 'package:filtrek_app/core/theme/app_typography.dart';

class AppointmentsGridSkeleton extends StatelessWidget {
  const AppointmentsGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colors.secondary.withOpacity(0.3),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colors.surface.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.surface.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 60,
                height: 12,
                color: colors.surface.withOpacity(0.2),
                margin: EdgeInsets.symmetric(vertical: 4),
              ),
              Container(
                width: 40,
                height: 12,
                color: colors.surface.withOpacity(0.2),
                margin: EdgeInsets.symmetric(vertical: 4),
              ),
            ],
          ),
        );
      },
    );
  }
}
