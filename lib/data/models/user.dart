import 'package:booking/domain/domain.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String displayName;
  final String email;
  final String avatar;

  final String token;
  final bool needChangePassword;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.email,
    required this.avatar,
    required this.token,
    required this.needChangePassword,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      displayName: displayName,
      email: email,
      avatar: avatar,
      token: token,
      needChangePassword: needChangePassword,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'] ?? 0,
      firstName: json['user']['first_name'] ?? '',
      lastName: json['user']['last_name'] ?? '',
      displayName: json['user']['display_name'] ?? '',
      email: json['user']['email'] ?? '',
      avatar: json['user']['avatar'] ?? '',
      needChangePassword: json['user']['need_update_pw'] == 1,
      token: json['access_token'] ?? '',
    );
  }
}
