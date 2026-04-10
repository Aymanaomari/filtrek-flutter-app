import 'package:flutter/material.dart';

class CoachGridSkeleton extends StatelessWidget {
  final int itemCount;
  const CoachGridSkeleton({Key? key, this.itemCount = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(itemCount, (index) {
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.tertiary.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[400]!.withOpacity(0.7),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile picture placeholder
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.outline.withOpacity(0.18),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Name placeholder
                    Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: colors.outline.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 4),
                    // Specialization placeholder
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors.outline.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              // Overlay for shimmer effect
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
