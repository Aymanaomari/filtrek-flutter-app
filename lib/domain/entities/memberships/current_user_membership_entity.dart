import 'package:filtrek_app/domain/entities/memberships/pack_entity.dart';

class CurrentUserMembershipEntity {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int remainingPoints;
  final PackEntity pack;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String gymName;
  final String gymId;
  final int collective_remaining_points;

  const CurrentUserMembershipEntity(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.remainingPoints,
      required this.pack,
      required this.createdAt,
      required this.updatedAt,
      required this.gymName,
      required this.gymId,
      required this.collective_remaining_points});
}
