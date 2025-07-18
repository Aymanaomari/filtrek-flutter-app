import 'package:filtrek_app/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:filtrek_app/data/datasources/remote/membership_remote_ds.dart';
import 'package:filtrek_app/data/models/memberships/current_user_membership_model.dart';
import 'package:filtrek_app/domain/entities/memberships/current_user_membership_entity.dart';
import 'package:filtrek_app/domain/repositories/memeber_ship_repository.dart';

class MembershipRepositoryImp extends MemeberShipRepository {
  final MembershipRemoteDs membershipRemoteDs;
  final AuthLocalDataSource authlocalDs;

  MembershipRepositoryImp(
      {required this.membershipRemoteDs, required this.authlocalDs});

  @override
  Future<CurrentUserMembershipEntity?> getCurrentUserMembership() async {
    // Get access token for API call
    String? accessToken = await authlocalDs.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return null;
    }
    var response = CurrentUserMembershipModel.fromJson(
        await membershipRemoteDs.getCurrentMemberShip(accessToken));
    return response.toEntity();
  }
}
