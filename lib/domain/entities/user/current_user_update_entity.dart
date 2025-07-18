import 'package:filtrek_app/data/models/user/current_user_update_model.dart';

class CurrentUserUpdateEntity {
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? phoneCountryCode;
  final String? profilePictureUrl;
  final String? gender;
  final double? weight;
  final int? age;

  CurrentUserUpdateEntity({
    this.username,
    this.email,
    this.phoneNumber,
    this.phoneCountryCode,
    this.profilePictureUrl,
    this.gender,
    this.weight,
    this.age,
  });

  factory CurrentUserUpdateEntity.fromModel(CurrentUserUpdateModel model) {
    return CurrentUserUpdateEntity(
      username: model.username,
      email: model.email,
      phoneNumber: model.phoneNumber,
      phoneCountryCode: model.phoneCountryCode,
      profilePictureUrl: model.profilePictureUrl,
      gender: model.gender,
      weight: model.weight,
      age: model.age,
    );
  }

  CurrentUserUpdateModel toModel() {
    return CurrentUserUpdateModel(
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      phoneCountryCode: phoneCountryCode,
      profilePictureUrl: profilePictureUrl,
      gender: gender,
      weight: weight,
      age: age,
    );
  }

  CurrentUserUpdateEntity copyWith({
    String? username,
    String? email,
    String? phoneNumber,
    String? phoneCountryCode,
    String? profilePictureUrl,
    String? gender,
    double? weight,
    int? age,
  }) {
    return CurrentUserUpdateEntity(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (username != null) data['username'] = username;
    if (email != null) data['email'] = email;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (phoneCountryCode != null) data['phone_country_code'] = phoneCountryCode;
    if (profilePictureUrl != null)
      data['profile_picture_url'] = profilePictureUrl;
    if (gender != null) data['gender'] = gender;
    if (weight != null) data['weight'] = weight;
    if (age != null) data['age'] = age;
    return data;
  }
}
