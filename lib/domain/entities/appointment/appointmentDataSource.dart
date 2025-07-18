import 'package:filtrek_app/domain/entities/appointment/coaching_appointment.dart';

/// Generic appointment data source for calendar implementations.
/// This can be easily replaced with another calendar library without changing the interface.
class MeetingDataSource {
  /// Creates an appointment data source that holds a collection of appointments
  final List<CoachingAppointment> appointments;

  MeetingDataSource(this.appointments);

  /// Get the start time of an appointment at the given index
  DateTime getStartTime(int index) => _getAppointment(index).startTime;

  /// Get the end time of an appointment at the given index
  DateTime getEndTime(int index) => _getAppointment(index).endTime;

  /// Get the subject/title of an appointment at the given index
  String getSubject(int index) => _getAppointment(index).subject;

  /// Get the color of an appointment at the given index
  dynamic getColor(int index) => _getAppointment(index).color;

  /// Check if an appointment at the given index is an all-day event
  bool isAllDay(int index) => _getAppointment(index).isAllDay;

  /// Get the appointment at the given index
  CoachingAppointment _getAppointment(int index) {
    if (index < 0 || index >= appointments.length) {
      throw Exception('Invalid appointment index: $index');
    }
    return appointments[index];
  }

  /// Check if any appointment is a break
  bool get isbreak {
    if (appointments.isEmpty) return false;
    return appointments.any((a) => a.isBreak == true);
  }

  /// Get all appointments
  List<CoachingAppointment> getAppointments() => appointments;

  /// Get the count of appointments
  int get count => appointments.length;
}
