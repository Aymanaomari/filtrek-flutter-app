import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:filtrek_app/domain/repositories/gym_repository.dart';

class GetSingleGymUsecase {
  final GymRepository gymRepository;
  GetSingleGymUsecase({required this.gymRepository});

  Future<SingleGymEntity> call(String gymId) async {
    return await gymRepository.getSingleGym(gymId: gymId);
  }
}
