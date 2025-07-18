enum UserRole {
  user('User'),
  admin('Admin'),
  gymAdmin('gym_admin'),
  coach('coach');

  final String value;
  const UserRole(this.value);

  static UserRole? fromString(String? value) {
    if (value == null) return null;
    return UserRole.values.firstWhere(
      (role) => role.value.toLowerCase() == value.toLowerCase(),
      orElse: () => UserRole.user,
    );
  }
}
