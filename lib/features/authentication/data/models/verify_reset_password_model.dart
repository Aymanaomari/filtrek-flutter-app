import 'package:filtrek_app/features/authentication/domain/entities/verify_reset_password_entity.dart';

class VerifyResetPasswordModel {
  final String userId;
  final String otpCode;
  VerifyResetPasswordModel({required this.userId, required this.otpCode});

  Map<String, dynamic> toJson() {
    return {"userId": userId, "otpCode": otpCode};
  }

  factory VerifyResetPasswordModel.fromEntity(
      VerifyResetPasswordEntity entity) {
    return VerifyResetPasswordModel(
      userId: entity.userId,
      otpCode: entity.otpCode,
    );
  }
}
