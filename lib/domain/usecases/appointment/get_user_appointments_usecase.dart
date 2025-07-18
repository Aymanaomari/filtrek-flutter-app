import 'package:filtrek_app/domain/entities/appointment/client_appointment_entity.dart';
import 'package:filtrek_app/domain/repositories/appointments_repository.dart';

class GetUserAppointmentsUsecase {
  final AppointmentsRepository _appointmentsRepository;

  GetUserAppointmentsUsecase(
      {required AppointmentsRepository appointmentsRepository})
      : _appointmentsRepository = appointmentsRepository;

  Future<List<ClientAppointmentEntity>> call() async {
    return await _appointmentsRepository.getCurrentUserAppointments();
  }
}
