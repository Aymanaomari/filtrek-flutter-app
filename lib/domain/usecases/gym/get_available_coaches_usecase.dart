import 'package:filtrek_app/domain/entities/gym/available_coaches_entity.dart';
import 'package:filtrek_app/domain/repositories/gym_repository.dart';

class GetAvailableCoachesUsecase {
  final GymRepository _gymRepository;

  GetAvailableCoachesUsecase({required GymRepository gymRepository})
      : _gymRepository = gymRepository;

  Future<AvailableCoachesEntity> call(String gymId) async {
    return await _gymRepository.getAvailableCoaches(gymId);
  }
}
