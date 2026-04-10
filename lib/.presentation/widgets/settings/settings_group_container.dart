import 'package:flutter/material.dart';

class SettingsGroupContainer extends StatelessWidget {
  final List<Widget> children;
  const SettingsGroupContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: color.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
