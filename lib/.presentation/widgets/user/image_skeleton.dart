import 'package:flutter/material.dart';

class ImageSkeleton extends StatelessWidget {
  const ImageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
