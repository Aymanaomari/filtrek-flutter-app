class PackEntity {
  final String id;
  final String name;
  final String description;
  final String price;
  final int durationMonths;
  final int collectiveSessionsLimit;
  final int coachSessionsLimit;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PackEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMonths,
    required this.collectiveSessionsLimit,
    required this.coachSessionsLimit,
    required this.createdAt,
    required this.updatedAt,
  });
}
