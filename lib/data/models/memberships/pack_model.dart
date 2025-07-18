import 'package:filtrek_app/domain/entities/memberships/pack_entity.dart';

class PackModel extends PackEntity {
  const PackModel({
    required String id,
    required String name,
    required String description,
    required String price,
    required int durationMonths,
    required int collectiveSessionsLimit,
    required int coachSessionsLimit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          durationMonths: durationMonths,
          collectiveSessionsLimit: collectiveSessionsLimit,
          coachSessionsLimit: coachSessionsLimit,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory PackModel.fromJson(Map<String, dynamic> json) {
    return PackModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      durationMonths: json['duration_months'],
      collectiveSessionsLimit: json['collective_sessions_limit'] ?? 0,
      coachSessionsLimit: json['coach_sessions_limit'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration_months': durationMonths,
      'collective_sessions_limit': collectiveSessionsLimit,
      'coach_sessions_limit': coachSessionsLimit,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  PackEntity toEntity() => this;
}
