import 'package:filtrek_app/end_points.dart';
import 'package:filtrek_app/core/class/crud.dart';

class MembershipRemoteDs {
  final Crud crud;

  MembershipRemoteDs({required this.crud});
  Future<Map<String, dynamic>> getCurrentMemberShip(String accessToken) async {
    return await crud.getData(
        EndPoints.currentMembership, {'authorization': 'Bearer $accessToken'});
  }
}
