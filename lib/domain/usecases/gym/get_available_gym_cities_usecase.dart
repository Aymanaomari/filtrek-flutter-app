import 'package:filtrek_app/domain/repositories/gym_repository.dart';

class GetAvailabeGymCitiesUsecase {
  final GymRepository gymRepository;

  GetAvailabeGymCitiesUsecase({required this.gymRepository});
  Future<List<String>> call() async {
    return await gymRepository.getAvailbleGymCities();
  }
}
