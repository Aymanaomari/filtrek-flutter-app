import 'package:filtrek_app/domain/entities/memberships/current_user_membership_entity.dart';
import 'package:filtrek_app/domain/repositories/memeber_ship_repository.dart';

class GetCurrentUserMembershipUsecase {
  final MemeberShipRepository memeberShipRepository;

  GetCurrentUserMembershipUsecase({required this.memeberShipRepository});

  Future<CurrentUserMembershipEntity?> call() async {
    return await memeberShipRepository.getCurrentUserMembership();
  }
}
