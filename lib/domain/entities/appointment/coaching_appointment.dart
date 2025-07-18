import 'package:flutter/material.dart';

/// Represents a coaching appointment event
/// Independent of any calendar library implementation
class CoachingAppointment {
  /// The title/name of the event
  final String subject;

  /// The start time of the appointment
  final DateTime startTime;

  /// The end time of the appointment
  final DateTime endTime;

  /// The color associated with the appointment
  final Color color;

  /// Whether this is an all-day event
  final bool isAllDay;

  /// Whether this appointment is a break/break time
  final bool isBreak;

  /// Creates a coaching appointment with required details.
  CoachingAppointment(
    this.subject,
    this.startTime,
    this.endTime,
    this.color,
    this.isAllDay,
    this.isBreak,
  );

  /// Get the duration of the appointment
  Duration get duration => endTime.difference(startTime);

  /// Check if the appointment is happening now
  bool get isHappening {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  /// Check if the appointment has passed
  bool get hasEnded => DateTime.now().isAfter(endTime);

  @override
  String toString() {
    return 'CoachingAppointment(subject: $subject, startTime: $startTime, endTime: $endTime, isBreak: $isBreak)';
  }
}
