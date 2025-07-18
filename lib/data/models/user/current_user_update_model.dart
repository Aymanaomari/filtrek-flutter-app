class CurrentUserUpdateModel {
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? phoneCountryCode;
  final String? profilePictureUrl;
  final String? gender;
  final double? weight;
  final int? age;

  CurrentUserUpdateModel({
    this.username,
    this.email,
    this.phoneNumber,
    this.phoneCountryCode,
    this.profilePictureUrl,
    this.gender,
    this.weight,
    this.age,
  });

  factory CurrentUserUpdateModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserUpdateModel(
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      phoneCountryCode: json['phone_country_code'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      gender: json['gender'] as String?,
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      age: json['age'] as int?,
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
