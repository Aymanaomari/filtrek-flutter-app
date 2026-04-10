import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: colors.onSecondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(999)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.notifications_none,
                color: colors.onSecondary, size: 28),
          ),
          Positioned(
              right: 14,
              top: 14,
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(99)),
              ))
        ],
      ),
    );
  }
}
