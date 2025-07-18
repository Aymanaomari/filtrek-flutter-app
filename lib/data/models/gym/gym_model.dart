import 'package:filtrek_app/domain/entities/gym/gym_entity.dart';

class GymModel extends GymEntity {
  const GymModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    super.imageUrl,
    super.rating,
    super.price,
    super.category,
    super.location,
    super.amenities,
    super.workingHours,
  });

  factory GymModel.fromJson(Map<String, dynamic> json) {
    return GymModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      imageUrl: json['gym_picture']?.toString(),
      rating: json['rating_avg']?.toDouble(),
      price: json['startPrice']?.toDouble(),
      category: json['category']?.toString(),
      location: json['location'] as Map<String, dynamic>?,
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : null,
      workingHours: json['workingHours'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'gym_picture': imageUrl,
      'rating': rating,
      'startPrice': price,
      'category': category,
      'location': location,
      'amenities': amenities,
      'workingHours': workingHours,
    };
  }

  GymEntity toEntity() {
    return GymEntity(
      id: id,
      name: name,
      description: description,
      address: address,
      imageUrl: imageUrl,
      rating: rating,
      price: price,
      category: category,
      location: location,
      amenities: amenities,
      workingHours: workingHours,
    );
  }

  factory GymModel.fromEntity(GymEntity entity) {
    return GymModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      address: entity.address,
      imageUrl: entity.imageUrl,
      rating: entity.rating,
      price: entity.price,
      category: entity.category,
      location: entity.location,
      amenities: entity.amenities,
      workingHours: entity.workingHours,
    );
  }
}
