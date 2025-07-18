import '../../../domain/entities/gym/single_gym_entity.dart';
import '../../../domain/entities/gym/address_entity.dart';

class SingleGymModel {
  final String id;
  final String name;
  final double ratingAvg;
  final AddressModel address;
  final String openTime;
  final String closeTime;
  final String openDays;
  final List<String> amenities;
  final String? gymPicture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String completeAddress;
  final String startPrice;
  final String description;

  SingleGymModel({
    required this.id,
    required this.name,
    required this.ratingAvg,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.openDays,
    required this.amenities,
    this.gymPicture,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.completeAddress,
    required this.startPrice,
    required this.description,
  });

  factory SingleGymModel.fromJson(Map<String, dynamic> json) {
    return SingleGymModel(
        id: json['id'],
        name: json['name'],
        ratingAvg: (json['rating_avg'] as num).toDouble(),
        address: AddressModel.fromJson(json['address']),
        openTime: json['open_time'],
        closeTime: json['close_time'],
        openDays: json['open_days'],
        amenities: (json['amenities'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        gymPicture: json['gym_picture'],
        description: json["description"],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        deletedAt: json['deletedAt'] != null
            ? DateTime.parse(json['deletedAt'])
            : null,
        completeAddress: json['completeAddress'],
        startPrice: json['startPrice'].toString());
  }

  SingleGymEntity toEntity() {
    return SingleGymEntity(
        id: id,
        name: name,
        ratingAvg: ratingAvg,
        address: address.toEntity(),
        openTime: openTime,
        closeTime: closeTime,
        openDays: openDays,
        amenities: amenities,
        gymPicture: gymPicture,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: deletedAt,
        completeAddress: completeAddress,
        startPrice: startPrice,
        description: description);
  }
}

class AddressModel {
  final String id;
  final String streetNumber;
  final String streetName;
  final String? neighborhood;
  final String city;
  final String postalCode;
  final String country;
  final double? latitude;
  final double? longitude;

  AddressModel({
    required this.id,
    required this.streetNumber,
    required this.streetName,
    this.neighborhood,
    required this.city,
    required this.postalCode,
    required this.country,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      streetNumber: json['streetNumber'],
      streetName: json['streetName'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      postalCode: json['postalCode'],
      country: json['country'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      streetNumber: streetNumber,
      streetName: streetName,
      neighborhood: neighborhood,
      city: city,
      postalCode: postalCode,
      country: country,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
