import 'package:filtrek_app/domain/entities/memberships/current_user_membership_entity.dart';

abstract class MemeberShipRepository {
  Future<CurrentUserMembershipEntity?> getCurrentUserMembership();
}
