import 'package:filtrek_app/domain/entities/appointment/client_appointment_entity.dart';

/// Generic client appointment data source for calendar implementations.
/// This can be easily replaced with another calendar library without changing the interface.
class ClientAppointmentDataSource {
  /// Creates a client appointment data source that holds a collection of appointments
  final List<ClientAppointmentEntity> appointments;

  ClientAppointmentDataSource(this.appointments);

  /// Get the start time of an appointment at the given index
  DateTime getStartTime(int index) => _getAppointment(index).startTime;

  /// Get the end time of an appointment at the given index
  DateTime getEndTime(int index) => _getAppointment(index).endTime;

  /// Get the subject/title of an appointment at the given index
  String? getSubject(int index) => _getAppointment(index).subject;

  /// Get the color of an appointment at the given index
  dynamic getColor(int index) => _getAppointment(index).color;

  /// Check if an appointment at the given index is an all-day event
  bool isAllDay(int index) => _getAppointment(index).isAllDay;

  /// Get the appointment at the given index
  ClientAppointmentEntity _getAppointment(int index) {
    if (index < 0 || index >= appointments.length) {
      throw Exception('Invalid appointment index: $index');
    }
    return appointments[index];
  }

  /// Get all appointments
  List<ClientAppointmentEntity> getAppointments() => appointments;

  /// Get the count of appointments
  int get count => appointments.length;
}
