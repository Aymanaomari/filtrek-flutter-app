import 'package:filtrek_app/features/authentication/domain/entities/verify_account_entity.dart';

class VerifyAccountModel {
  final String userId;
  final String otpCode;

  VerifyAccountModel({
    required this.userId,
    required this.otpCode,
  });

  // Convert VerifyAccountModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'otpCode': otpCode,
    };
  }

  // Create VerifyAccountModel from JSON
  factory VerifyAccountModel.fromJson(Map<String, dynamic> json) {
    return VerifyAccountModel(
      userId: json['userId'] ?? '',
      otpCode: json['otpCode'] ?? '',
    );
  }

  // Convert to JSON string
  String toJsonString() {
    return toJson().toString();
  }

  // Copy with method for creating modified copies
  VerifyAccountModel copyWith({
    String? userId,
    String? otpCode,
  }) {
    return VerifyAccountModel(
      userId: userId ?? this.userId,
      otpCode: otpCode ?? this.otpCode,
    );
  }

  // Convert VerifyAccountModel to VerifyAccountEntity (Model -> Entity)
  VerifyAccountEntity toEntity() {
    return VerifyAccountEntity(
      userId: userId,
      otpCode: otpCode,
    );
  }

  // Create VerifyAccountModel from VerifyAccountEntity (Entity -> Model)
  factory VerifyAccountModel.fromEntity(VerifyAccountEntity entity) {
    return VerifyAccountModel(
      userId: entity.userId,
      otpCode: entity.otpCode,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VerifyAccountModel &&
        other.userId == userId &&
        other.otpCode == otpCode;
  }

  // Hash code
  @override
  int get hashCode {
    return Object.hash(userId, otpCode);
  }

  @override
  String toString() {
    return 'VerifyAccountModel(userId: $userId, otpCode: $otpCode)';
  }
}
