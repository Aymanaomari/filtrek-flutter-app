import 'package:filtrek_app/features/authentication/data/models/verify_account_model.dart';

class VerifyAccountEntity {
  final String userId;
  final String otpCode;

  const VerifyAccountEntity({
    required this.userId,
    required this.otpCode,
  });

  // Convert VerifyAccountEntity to VerifyAccountModel (Entity -> Model)
  VerifyAccountModel toModel() {
    return VerifyAccountModel(
      userId: userId,
      otpCode: otpCode,
    );
  }

  // Create VerifyAccountEntity from VerifyAccountModel (Model -> Entity)
  factory VerifyAccountEntity.fromModel(VerifyAccountModel model) {
    return VerifyAccountEntity(
      userId: model.userId,
      otpCode: model.otpCode,
    );
  }

  // Copy with method for creating modified copies
  VerifyAccountEntity copyWith({
    String? userId,
    String? otpCode,
  }) {
    return VerifyAccountEntity(
      userId: userId ?? this.userId,
      otpCode: otpCode ?? this.otpCode,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VerifyAccountEntity &&
        other.userId == userId &&
        other.otpCode == otpCode;
  }

  // Hash code
  @override
  int get hashCode {
    return Object.hash(userId, otpCode);
  }

  // String representation
  @override
  String toString() {
    return 'VerifyAccountEntity(userId: $userId, otpCode: $otpCode)';
  }

  // Validation methods
  bool get isValid {
    return userId.isNotEmpty && otpCode.isNotEmpty && isValidOtpCode;
  }

  bool get isValidOtpCode {
    // OTP code should be 4-6 digits
    return RegExp(r'^\d{4,6}$').hasMatch(otpCode);
  }

  String? get userIdError {
    if (userId.isEmpty) return 'User ID is required';
    return null;
  }

  String? get otpCodeError {
    if (otpCode.isEmpty) return 'OTP code is required';
    if (!isValidOtpCode) return 'OTP code must be 4-6 digits';
    return null;
  }
}
