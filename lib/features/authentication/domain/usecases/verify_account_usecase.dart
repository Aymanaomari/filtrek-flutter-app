import 'package:filtrek_app/features/authentication/data/models/verify_account_model.dart';
import 'package:filtrek_app/features/authentication/domain/entities/verify_account_entity.dart';
import 'package:filtrek_app/features/authentication/domain/repositories/authentification_repository.dart';

class VerifyAccountUsecase {
  final AuthentificationRepository authentificationRepository;
  VerifyAccountUsecase({required this.authentificationRepository});
  Future<dynamic> call(VerifyAccountEntity verificationAccountEntity) async {
    await authentificationRepository.verifyAccount(
        VerifyAccountModel.fromEntity(verificationAccountEntity));
  }
}
