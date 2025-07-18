import 'package:filtrek_app/core/class/local_notifications_service.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // LocalNotificationsService.showBasicNotification();
          },
          child: const Text('Center Button'),
        ),
      ),
    );
  }
}
