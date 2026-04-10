import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  const ImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image,
              size: 48,
              color: Colors.grey[400],
            ),
            SizedBox(height: 8),
            Text(
              'Failed to load image',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
