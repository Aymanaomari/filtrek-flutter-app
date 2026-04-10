import 'package:flutter/material.dart';

/// Placeholder calendar widget for coach planning
/// This widget can be replaced with a different calendar implementation in the future
class CustomSfcalendar extends StatefulWidget {
  const CustomSfcalendar({super.key});

  @override
  State<CustomSfcalendar> createState() => _CustomSfcalendarState();
}

class _CustomSfcalendarState extends State<CustomSfcalendar> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: color.surface,
        border: Border.all(
          color: color.outline.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month,
              size: 48,
              color: color.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Coach Calendar View',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Schedule appointments and plan your coaching sessions',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color.outline,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Calendar implementation coming soon'),
                  ),
                );
              },
              child: const Text('Add Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
