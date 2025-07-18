import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/models/gym/available_coaches_model.dart';

class GymRemoteDs {
  final Crud crud;

  GymRemoteDs({required this.crud});

  Future<Map<String, dynamic>> getAllGyms({
    required int page,
    required int limit,
    String? sortBy,
    String? order,
    int? minPrice,
    int? maxPrice,
    String? name,
  }) async {
    String query = '?page=$page&limit=$limit';

    if (sortBy != null && sortBy.isNotEmpty) {
      query += '&sortBy=$sortBy';
    }

    if (order != null && order.isNotEmpty) {
      query += '&order=$order';
    }

    if (minPrice != null) {
      query += '&minPrice=$minPrice';
    }
    if (maxPrice != null) {
      query += '&maxPrice=$maxPrice';
    }
    if (name != null && name.isNotEmpty) {
      query += '&name=$name';
    }

    return await crud.getData('${EndPoints.getAllGyms}$query');
  }

  Future<Map<String, dynamic>> getSingleGym({required String gymId}) async {
    print('Fetching gym with ID: $gymId');
    print('Making request to: ${EndPoints.singleGym}/$gymId');

    final result = await crud.getData("${EndPoints.singleGym}/$gymId");

    print('Gym data received: $result');
    return result;
  }

  Future<Map<String, dynamic>> getTopGyms() async {
    final result = await crud.getData(EndPoints.topGyms);
    return result;
  }

  Future<Map<String, dynamic>> getAvailabeGymCities() async {
    final result = await crud.getData(EndPoints.getAvailbleGymCities);
    return result;
  }

  Future<AvailableCoachesModel> getAvailabaleCoaches(String gymId) async {
    final result = await crud
        .getData(EndPoints.getAvailableCoaches.replaceFirst(":gymId", gymId));
    return AvailableCoachesModel.fromJson(result);
  }
}
