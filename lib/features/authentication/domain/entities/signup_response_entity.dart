import 'package:filtrek_app/features/authentication/data/models/signup_response_model.dart';

class SignupResponseEntity {
  final String id;
  final String phone;

  const SignupResponseEntity({
    required this.id,
    required this.phone,
  });

  // Convert SignupResponseEntity to SignupResponseModel (Entity -> Model)
  SignupResponseModel toModel() {
    return SignupResponseModel(
      id: id,
      phone: phone,
    );
  }

  // Create SignupResponseEntity from SignupResponseModel (Model -> Entity)
  factory SignupResponseEntity.fromModel(SignupResponseModel model) {
    return SignupResponseEntity(
      id: model.id,
      phone: model.phone,
    );
  }

  // Copy with method for creating modified copies
  SignupResponseEntity copyWith({
    String? id,
    String? phone,
  }) {
    return SignupResponseEntity(
      id: id ?? this.id,
      phone: phone ?? this.phone,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SignupResponseEntity &&
        other.id == id &&
        other.phone == phone;
  }

  // Hash code
  @override
  int get hashCode {
    return Object.hash(id, phone);
  }

  // String representation
  @override
  String toString() {
    return 'SignupResponseEntity(id: $id, phone: $phone)';
  }

  // Validation methods
  bool get isValid {
    return id.isNotEmpty && phone.isNotEmpty;
  }

  String? get idError {
    if (id.isEmpty) return 'User ID is required';
    return null;
  }

  String? get phoneError {
    if (phone.isEmpty) return 'Phone is required';
    return null;
  }
}
