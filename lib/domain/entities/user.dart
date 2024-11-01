class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String displayName;
  final String email;
  final String avatar;

  final String token;
  final bool needChangePassword;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.email,
    required this.avatar,
    required this.token,
    required this.needChangePassword,
  });
}
