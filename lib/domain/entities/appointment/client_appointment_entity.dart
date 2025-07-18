import 'package:flutter/material.dart';

/// Represents a client appointment entity
/// Independent of any calendar library implementation
class ClientAppointmentEntity {
  /// The start time of the appointment
  final DateTime startTime;

  /// The end time of the appointment
  final DateTime endTime;

  /// The ID of the coach providing the appointment
  final String coachId;

  /// The unique identifier for this appointment
  final String appointmentId;

  /// The ID of the client booking the appointment
  final String clientId;

  /// The profile image/URL of the coach
  final String coachProfile;

  /// The name of the coach
  final String coachName;

  /// The profession/specialization of the coach
  final String coachProfession;

  /// The title/subject of the appointment
  String? subject;

  /// The color associated with the appointment
  Color? color;

  /// Whether this is an all-day event
  bool isAllDay;

  /// Creates a client appointment entity
  ClientAppointmentEntity(
    this.startTime,
    this.endTime,
    this.coachId,
    this.appointmentId,
    this.clientId,
    this.coachProfile,
    this.coachName,
    this.coachProfession, {
    this.subject,
    this.color,
    this.isAllDay = false,
  });

  /// Named constructor for model serialization
  factory ClientAppointmentEntity.fromModel({
    required String coachId,
    required String appointmentId,
    required String clientId,
    required String coachProfile,
    required String coachName,
    required DateTime from,
    required DateTime to,
    required bool isAllDay,
    required String coachProfession,
    String? subject,
    Color? color,
  }) {
    return ClientAppointmentEntity(
      from,
      to,
      coachId,
      appointmentId,
      clientId,
      coachProfile,
      coachName,
      coachProfession,
      subject: subject,
      color: color,
      isAllDay: isAllDay,
    );
  }

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
    return 'ClientAppointmentEntity(coachId: $coachId, appointmentId: $appointmentId, clientId: $clientId, coachName: $coachName, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay)';
  }
}
