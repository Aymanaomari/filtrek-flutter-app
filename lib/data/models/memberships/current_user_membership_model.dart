import 'package:filtrek_app/domain/entities/memberships/current_user_membership_entity.dart';
import 'package:filtrek_app/data/models/memberships/pack_model.dart';

class CurrentUserMembershipModel extends CurrentUserMembershipEntity {
  const CurrentUserMembershipModel({
    required super.id,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.remainingPoints,
    required PackModel super.pack,
    required super.createdAt,
    required super.updatedAt,
    required super.gymName,
    required super.gymId,
    required super.collective_remaining_points,
  });

  factory CurrentUserMembershipModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserMembershipModel(
      id: json['id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      status: json['status'],
      remainingPoints: json['remaining_points'],
      pack: PackModel.fromJson(json['pack']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      gymName: json['gymname'],
      gymId: json['gymId'],
      collective_remaining_points: json['collective_remaining_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'remaining_points': remainingPoints,
      'pack': (pack as PackModel).toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'gymname': gymName,
      'gymId': gymId,
      'collective_remaining_points': collective_remaining_points,
    };
  }

  CurrentUserMembershipEntity toEntity() => this;
}
