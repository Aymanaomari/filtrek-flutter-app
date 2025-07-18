import 'package:filtrek_app/domain/entities/appointment/make_appointment_request_entity.dart';

abstract class AppointmentsRepository {
  getCurrentUserAppointments();
  Future<List<String>> getCoachAvailableTimes(String CoachId, String day);
  makeAppointment(MakeAppointmentRequestEntity data);
}
