class GymEntity {
  final String id;
  final String name;
  final String description;
  final String address;
  final String? imageUrl;
  final double? rating;
  final double? price;
  final String? category;
  final Map<String, dynamic>? location; // For lat/lng coordinates
  final List<String>? amenities;
  final Map<String, dynamic>? workingHours;

  const GymEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    this.imageUrl,
    this.rating,
    this.price,
    this.category,
    this.location,
    this.amenities,
    this.workingHours,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GymEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
