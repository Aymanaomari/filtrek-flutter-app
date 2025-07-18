import 'package:filtrek_app/features/authentication/domain/entities/request_reset_password_entity.dart';

class RequestResetPasswordModel {
  final String phoneCountryCode;
  final String phoneNumber;

  RequestResetPasswordModel(
      {required this.phoneCountryCode, required this.phoneNumber});

  factory RequestResetPasswordModel.fromEntity(
      RequestResetPasswordEntity entity) {
    return RequestResetPasswordModel(
      phoneCountryCode: entity.phoneCountryCode,
      phoneNumber: entity.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneCountryCode': phoneCountryCode,
      'phoneNumber': phoneNumber,
    };
  }
}
