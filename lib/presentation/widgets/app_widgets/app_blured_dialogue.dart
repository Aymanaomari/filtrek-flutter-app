import 'package:flutter/material.dart';

class AppBluredDialogue extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onContinue;

  const AppBluredDialogue({
    Key? key,
    required this.title,
    required this.message,
    this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 16),
            Text(message,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onContinue ?? () => Navigator.of(context).pop(),
              child: const Text("Continue"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 44),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
