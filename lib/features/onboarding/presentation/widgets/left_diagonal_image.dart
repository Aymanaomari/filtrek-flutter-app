import 'package:flutter/material.dart';

class LeftDiagonalImage extends StatelessWidget {
  final String imagePath;
  final double height;

  const LeftDiagonalImage({
    super.key,
    required this.imagePath,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _LeftDiagonalClipper(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _LeftDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
