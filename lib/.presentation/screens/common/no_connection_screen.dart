import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoConnectionScreen({Key? key, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Connection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your network settings and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
          ],
        ),
      ),
    );
  }
}
