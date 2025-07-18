import 'package:filtrek_app/domain/entities/gym/top_gym_entity.dart';
import 'package:filtrek_app/domain/repositories/gym_repository.dart';

class GetTopGymsUsecase {
  final GymRepository gymRepository;

  GetTopGymsUsecase({required this.gymRepository});

  Future<TopGymEntity> call() async {
    return await gymRepository.getTopGyms();
  }
}
