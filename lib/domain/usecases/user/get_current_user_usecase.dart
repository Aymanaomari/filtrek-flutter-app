import 'package:filtrek_app/domain/entities/user/current_user_response_entity.dart';
import 'package:filtrek_app/domain/repositories/user_repository.dart';

class GetCurrentUserUsecase {
  final UserRepository userRepo;

  GetCurrentUserUsecase({required this.userRepo});

  Future<CurrentUserResponseEntity?> call() async {
    return await userRepo.getCurrentUser();
  }
}
