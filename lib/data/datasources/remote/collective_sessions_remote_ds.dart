import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';
import 'package:filtrek_app/data/models/collective_sessions/recent_collective_sessions_model.dart';

class CollectiveSessionsRemoteDs {
  final Crud crud;

  CollectiveSessionsRemoteDs({required this.crud});

  Future<RecentCollectiveSessionsModel> getAvailabaleCoaches(
      String gymId, String accessToken) async {
    print('[CollectiveSessionsRemoteDs] gymId: $gymId');
    print('[CollectiveSessionsRemoteDs] accessToken: $accessToken');
    final result = await crud.getData(
        EndPoints.getRecentCollectiveSessions.replaceAll(":gymId", gymId),
        {"authorization": "Bearer $accessToken"});

    print('[CollectiveSessionsRemoteDs] API result: $result');
    return RecentCollectiveSessionsModel.fromJson(result);
  }
}
