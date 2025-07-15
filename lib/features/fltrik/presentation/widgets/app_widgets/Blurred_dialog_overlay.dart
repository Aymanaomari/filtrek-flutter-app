import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredDialogOverlay extends StatelessWidget {
  final Widget child;

  const BlurredDialogOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Center(child: child),
      ],
    );
  }
}
