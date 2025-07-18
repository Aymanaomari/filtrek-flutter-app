import 'package:filtrek_app/domain/entities/collective_sessions/recent_collective_sessions_entity.dart';

abstract class CollectiveSessionsRepository {
  Future<RecentCollectiveSessionsEntity> getRecentCollectiveSessions(
      String gymId);
}
