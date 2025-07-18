import 'package:filtrek_app/data/models/gym/available_coaches_model.dart';

class AvailableCoachesEntity {
  final Map<String, List<CoachEntity>> availableCoaches;

  AvailableCoachesEntity({required this.availableCoaches});

  factory AvailableCoachesEntity.fromModel(AvailableCoachesModel model) {
    final map = <String, List<CoachEntity>>{};
    model.availableCoaches.forEach((key, value) {
      map[key] = value.map((coach) => CoachEntity.fromModel(coach)).toList();
    });
    return AvailableCoachesEntity(availableCoaches: map);
  }
}

class CoachEntity {
  final String coachId;
  final String coachName;
  final String specialization;
  final String? coachImage;

  CoachEntity({
    required this.coachId,
    required this.coachName,
    required this.specialization,
    required this.coachImage,
  });

  factory CoachEntity.fromModel(Coach coach) {
    return CoachEntity(
      coachId: coach.coachId,
      coachName: coach.coachName,
      specialization: coach.specialization,
      coachImage: coach.coachImage,
    );
  }
}
