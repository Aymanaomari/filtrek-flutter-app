import 'package:filtrek_app/domain/entities/gym/gyms_response_entity.dart';
import 'package:filtrek_app/domain/repositories/gym_repository.dart';

class GetAllGymsUsecase {
  final GymRepository gymRepository;

  GetAllGymsUsecase({required this.gymRepository});
  Future<GymsResponseEntity> call({
    required int page,
    required int limit,
    int? minPrice,
    int? maxPrice,
    String? name,
  }) async {
    return await gymRepository.getAllGyms(
      page: page,
      limit: limit,
      minPrice: minPrice,
      maxPrice: maxPrice,
      name: name,
    );
  }
}
