import 'package:filtrek_app/domain/entities/collective_sessions/recent_collective_sessions_entity.dart';
import 'package:filtrek_app/domain/repositories/collective_sessions_repository.dart';

class GetRecentCollectiveSessionsUsecase {
  final CollectiveSessionsRepository _collectiveSessionsRepository;

  GetRecentCollectiveSessionsUsecase(
      {required CollectiveSessionsRepository collectiveSessionsRepository})
      : _collectiveSessionsRepository = collectiveSessionsRepository;

  Future<RecentCollectiveSessionsEntity> call(String gymId) async {
    return _collectiveSessionsRepository.getRecentCollectiveSessions(gymId);
  }
}
