import 'package:filtrek_app/domain/entities/appointment/make_appointment_request_entity.dart';
import 'package:filtrek_app/domain/repositories/appointments_repository.dart';

class MakeAnAppointmentUsecase {
  final AppointmentsRepository _appointmentsRepository;

  MakeAnAppointmentUsecase(
      {required AppointmentsRepository appointmentsRepository})
      : _appointmentsRepository = appointmentsRepository;

  call(MakeAppointmentRequestEntity data) async {
    await _appointmentsRepository.makeAppointment(data);
  }
}
