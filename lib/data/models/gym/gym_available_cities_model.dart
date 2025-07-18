class GymAvailableCitiesModel {
  final List<String> data;

  const GymAvailableCitiesModel({
    required this.data,
  });

  factory GymAvailableCitiesModel.fromJson(Map<String, dynamic> json) {
    return GymAvailableCitiesModel(
      data: List<String>.from(json['data'] ?? []),
    );
  }
}
