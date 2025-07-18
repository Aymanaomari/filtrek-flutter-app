import 'package:filtrek_app/domain/entities/collective_sessions/recent_collective_sessions_entity.dart';

class RecentCollectiveSessionsModel {
  final List<CollectiveSessionModel> recentCollectiveSessions;

  RecentCollectiveSessionsModel({required this.recentCollectiveSessions});

  factory RecentCollectiveSessionsModel.fromJson(Map<String, dynamic> json) {
    final jsonList = json['data'] as List<dynamic>? ?? [];
    print(
        '[RecentCollectiveSessionsModel] Parsed sessions count: ${jsonList.length}');
    return RecentCollectiveSessionsModel(
      recentCollectiveSessions: jsonList
          .map((item) =>
              CollectiveSessionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  RecentCollectiveSessionsEntity toEntity() {
    return RecentCollectiveSessionsEntity(
      recentCollectiveSessions:
          recentCollectiveSessions.map((model) => model.toEntity()).toList(),
    );
  }
}

class CollectiveSessionModel {
  final String id;
  final String sessionDate;
  final String startTime;
  final String endTime;
  final String status;
  final int maxAppointments;
  final String createdAt;
  final String updatedAt;

  CollectiveSessionModel({
    required this.id,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.maxAppointments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollectiveSessionModel.fromJson(Map<String, dynamic> json) {
    return CollectiveSessionModel(
      id: (json['id'] ?? '').toString(),
      sessionDate: (json['session_date'] ?? '').toString(),
      startTime: (json['start_time'] ?? '').toString(),
      endTime: (json['end_time'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      maxAppointments:
          int.tryParse(json['max_appointments']?.toString() ?? '0') ?? 0,
      createdAt: (json['created_at'] ?? '').toString(),
      updatedAt: (json['updated_at'] ?? '').toString(),
    );
  }

  CollectiveSessionEntity toEntity() {
    return CollectiveSessionEntity(
      id: id,
      sessionDate: sessionDate,
      startTime: startTime,
      endTime: endTime,
      status: status,
      maxAppointments: maxAppointments,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
