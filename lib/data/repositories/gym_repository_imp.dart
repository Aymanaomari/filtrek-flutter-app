import 'package:filtrek_app/data/datasources/remote/gym_remote_ds.dart';
import 'package:filtrek_app/data/models/gym/gym_available_cities_model.dart';
import 'package:filtrek_app/data/models/gym/gyms_response_model.dart';
import 'package:filtrek_app/data/models/gym/single_gym_response_model.dart';
import 'package:filtrek_app/data/models/gym/top_gym_response_model.dart';
import 'package:filtrek_app/domain/entities/gym/available_coaches_entity.dart';
import 'package:filtrek_app/domain/entities/gym/gyms_response_entity.dart';
import 'package:filtrek_app/domain/entities/gym/single_gym_entity.dart';
import 'package:filtrek_app/domain/entities/gym/top_gym_entity.dart';
import 'package:filtrek_app/domain/repositories/gym_repository.dart';

class GymRepositoryImp implements GymRepository {
  final GymRemoteDs _gymRemoteDs;

  GymRepositoryImp({required GymRemoteDs gymRemoteDs})
      : _gymRemoteDs = gymRemoteDs;

  @override
  Future<GymsResponseEntity> getAllGyms({
    required int page,
    required int limit,
    String? sortBy,
    String? order,
    int? minPrice,
    int? maxPrice,
    String? name,
  }) async {
    final result = await _gymRemoteDs.getAllGyms(
        page: page,
        limit: limit,
        sortBy: sortBy,
        order: order,
        minPrice: minPrice,
        maxPrice: maxPrice,
        name: name);

    final model = GymsResponseModel.fromJson(result);
    return model.toEntity();
  }

  @override
  Future<SingleGymEntity> getSingleGym({required String gymId}) async {
    SingleGymModel response =
        SingleGymModel.fromJson(await _gymRemoteDs.getSingleGym(gymId: gymId));
    return response.toEntity();
  }

  @override
  Future<TopGymEntity> getTopGyms() async {
    var result = TopGymResponseModel.fromJson(await _gymRemoteDs.getTopGyms());
    return result.toEntity();
  }

  @override
  Future<List<String>> getAvailbleGymCities() async {
    var result = GymAvailableCitiesModel.fromJson(
        await _gymRemoteDs.getAvailabeGymCities());
    return result.data;
  }

  @override
  Future<AvailableCoachesEntity> getAvailableCoaches(String gymId) async {
    var result = AvailableCoachesEntity.fromModel(
        await _gymRemoteDs.getAvailabaleCoaches(gymId));
    return result;
  }
}
