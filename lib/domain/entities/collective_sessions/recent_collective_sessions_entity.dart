class RecentCollectiveSessionsEntity {
  final List<CollectiveSessionEntity> recentCollectiveSessions;

  RecentCollectiveSessionsEntity({required this.recentCollectiveSessions});
}

class CollectiveSessionEntity {
  final String id;
  final String sessionDate;
  final String startTime;
  final String endTime;
  final String status;
  final int maxAppointments;
  final String createdAt;
  final String updatedAt;

  CollectiveSessionEntity({
    required this.id,
    required this.sessionDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.maxAppointments,
    required this.createdAt,
    required this.updatedAt,
  });
}
