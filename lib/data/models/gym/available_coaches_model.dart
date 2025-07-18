class AvailableCoachesModel {
  final Map<String, List<Coach>> availableCoaches;

  AvailableCoachesModel({required this.availableCoaches});

  factory AvailableCoachesModel.fromJson(Map<String, dynamic> json) {
    final map = <String, List<Coach>>{};
    json.forEach((key, value) {
      map[key] = (value as List).map((e) => Coach.fromJson(e)).toList();
    });
    return AvailableCoachesModel(availableCoaches: map);
  }
}

class Coach {
  final String coachId;
  final String coachName;
  final String specialization;
  final String coachImage;

  Coach({
    required this.coachId,
    required this.coachName,
    required this.specialization,
    required this.coachImage,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      coachId: json['coachId'],
      coachName: json['coachName'],
      specialization: json['specialization'],
      coachImage: json['coachImage'] ?? "",
    );
  }
}
