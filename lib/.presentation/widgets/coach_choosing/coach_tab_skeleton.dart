import 'package:flutter/material.dart';

class CoachTabSkeleton extends StatelessWidget {
  final int tabCount;
  const CoachTabSkeleton({Key? key, this.tabCount = 3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(tabCount, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: 80,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(18),
          ),
        );
      }),
    );
  }
}
