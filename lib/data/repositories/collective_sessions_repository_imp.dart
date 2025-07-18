import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/remote/collective_sessions_remote_ds.dart';
import 'package:filtrek_app/domain/entities/collective_sessions/recent_collective_sessions_entity.dart';
import 'package:filtrek_app/domain/repositories/collective_sessions_repository.dart';

class CollectiveSessionsRepositoryImp extends CollectiveSessionsRepository {
  final CollectiveSessionsRemoteDs _remoteDs;
  final AuthLocalDataSource _authLocalDs;

  CollectiveSessionsRepositoryImp(
      {required CollectiveSessionsRemoteDs remoteDs,
      required AuthLocalDataSource localDs})
      : _remoteDs = remoteDs,
        _authLocalDs = localDs;

  @override
  Future<RecentCollectiveSessionsEntity> getRecentCollectiveSessions(
      String gymId) async {
    String? accessToken = await _authLocalDs.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      return RecentCollectiveSessionsEntity(recentCollectiveSessions: []);
    }
    var response = await _remoteDs.getAvailabaleCoaches(gymId, accessToken);
    return response.toEntity();
  }
}
