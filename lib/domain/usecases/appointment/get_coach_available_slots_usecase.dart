import 'package:filtrek_app/domain/repositories/appointments_repository.dart';

class GetCoachAvailableSlotsUsecase {
  final AppointmentsRepository _appointmentsRepository;

  GetCoachAvailableSlotsUsecase(
      {required AppointmentsRepository appointmentsRepository})
      : _appointmentsRepository = appointmentsRepository;

  Future<List<String>> call(String coachId, String date) async {
    return await _appointmentsRepository.getCoachAvailableTimes(coachId, date);
  }
}
