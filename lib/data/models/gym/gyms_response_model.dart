import 'package:filtrek_app/data/models/gym/gym_model.dart';
import 'package:filtrek_app/domain/entities/gym/gyms_response_entity.dart';

class GymsResponseModel extends GymsResponseEntity {
  const GymsResponseModel({
    required super.data,
    required super.total,
    required super.page,
    required super.limit,
    required super.hasNextPage,
  });

  factory GymsResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] ?? [];
    final List<GymModel> gyms =
        dataList.map((gymData) => GymModel.fromJson(gymData)).toList();

    final int total = json['total']?.toInt() ?? 0;
    final int page = json['page']?.toInt() ?? 1;
    final int limit = json['limit']?.toInt() ?? 10;

    // Calculate hasNextPage based on pagination
    final bool hasNextPage = (page * limit) < total;

    return GymsResponseModel(
      data: gyms,
      total: total,
      page: page,
      limit: limit,
      hasNextPage: hasNextPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((gym) => (gym as GymModel).toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'hasNextPage': hasNextPage,
    };
  }

  GymsResponseEntity toEntity() {
    return GymsResponseEntity(
      data: data.map((gym) => (gym as GymModel).toEntity()).toList(),
      total: total,
      page: page,
      limit: limit,
      hasNextPage: hasNextPage,
    );
  }

  factory GymsResponseModel.fromEntity(GymsResponseEntity entity) {
    return GymsResponseModel(
      data: entity.data.map((gym) => GymModel.fromEntity(gym)).toList(),
      total: entity.total,
      page: entity.page,
      limit: entity.limit,
      hasNextPage: entity.hasNextPage,
    );
  }
}
