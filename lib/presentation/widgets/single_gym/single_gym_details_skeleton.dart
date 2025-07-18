import 'package:flutter/material.dart';

class SingleGymDetailsSkeleton extends StatelessWidget {
  final ColorScheme colors;
  final ScrollController scrollController;
  const SingleGymDetailsSkeleton({
    Key? key,
    required this.colors,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 24,
            color: colors.secondary.withOpacity(0.3),
            margin: const EdgeInsets.only(bottom: 12),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(right: index < 5 ? 12.0 : 0),
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: colors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 120,
            height: 24,
            color: colors.secondary.withOpacity(0.3),
            margin: const EdgeInsets.only(bottom: 12),
          ),
          Container(
            width: double.infinity,
            height: 40,
            color: colors.secondary.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
