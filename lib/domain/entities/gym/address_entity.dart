class AddressEntity {
  final String id;
  final String streetNumber;
  final String streetName;
  final String? neighborhood;
  final String city;
  final String postalCode;
  final String country;
  final double? latitude;
  final double? longitude;

  const AddressEntity({
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddressEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
