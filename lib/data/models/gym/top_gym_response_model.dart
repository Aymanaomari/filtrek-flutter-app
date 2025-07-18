import 'package:filtrek_app/data/models/gym/gym_model.dart';
import 'package:filtrek_app/domain/entities/gym/top_gym_entity.dart';

class TopGymResponseModel {
  final List<GymModel> data;

  TopGymResponseModel({
    required this.data,
  });

  factory TopGymResponseModel.fromJson(Map<String, dynamic> json) {
    return TopGymResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((gymJson) => GymModel.fromJson(gymJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((gym) => gym.toJson()).toList(),
    };
  }

  // Serialization to entity
  TopGymEntity toEntity() {
    return TopGymEntity(
      data: data.map((gym) => gym.toEntity()).toList(),
    );
  }
}
