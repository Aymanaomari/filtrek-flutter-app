import 'address_entity.dart';

class SingleGymEntity {
  final String id;
  final String name;
  final double ratingAvg;
  final AddressEntity address;
  final String openTime;
  final String closeTime;
  final String openDays;
  final String description;

  final List<String> amenities;
  final String? gymPicture;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String completeAddress;
  final String startPrice;

  const SingleGymEntity(
      {required this.id,
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
      required this.description,
      required this.startPrice});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SingleGymEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
