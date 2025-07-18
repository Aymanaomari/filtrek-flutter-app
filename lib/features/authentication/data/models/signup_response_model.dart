import 'package:filtrek_app/features/authentication/domain/entities/signup_response_entity.dart';

class SignupResponseModel {
  final String id;
  final String phone;

  SignupResponseModel({
    required this.id,
    required this.phone,
  });

  // Convert SignupResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
    };
  }

  // Create SignupResponseModel from JSON
  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // Convert to JSON string
  String toJsonString() {
    return toJson().toString();
  }

  // Copy with method for creating modified copies
  SignupResponseModel copyWith({
    String? id,
    String? phone,
  }) {
    return SignupResponseModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
    );
  }

  // Convert SignupResponseModel to SignupResponseEntity (Model -> Entity)
  SignupResponseEntity toEntity() {
    return SignupResponseEntity(
      id: id,
      phone: phone,
    );
  }

  // Create SignupResponseModel from SignupResponseEntity (Entity -> Model)
  factory SignupResponseModel.fromEntity(SignupResponseEntity entity) {
    return SignupResponseModel(
      id: entity.id,
      phone: entity.phone,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignupResponseModel &&
        other.id == id &&
        other.phone == phone;
  }

  // Hash code
  @override
  int get hashCode {
    return Object.hash(id, phone);
  }

  @override
  String toString() {
    return 'SignupResponseModel(id: $id, phone: $phone)';
  }
}
