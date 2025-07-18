import 'package:filtrek_app/domain/entities/gym/available_coaches_entity.dart';
import 'package:filtrek_app/domain/entities/gym/gyms_response_entity.dart';
import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:filtrek_app/domain/entities/gym/top_gym_entity.dart';

abstract class GymRepository {
  Future<GymsResponseEntity> getAllGyms({
    required int page,
    required int limit,
    int? minPrice,
    int? maxPrice,
    String? name,
    String? sortBy,
    String? order,
  });
  Future<SingleGymEntity> getSingleGym({required String gymId});
  Future<TopGymEntity> getTopGyms();
  Future<List<String>> getAvailbleGymCities();
  Future<AvailableCoachesEntity> getAvailableCoaches(String gymId);
}
