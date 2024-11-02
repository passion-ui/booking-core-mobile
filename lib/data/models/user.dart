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

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'display_name': displayName,
        'email': email,
        'avatar_url': avatar,
        'need_update_pw': needChangePassword ? 1 : 0,
      },
      'access_token': token,
    };
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      displayName: user.displayName,
      email: user.email,
      avatar: user.avatar,
      needChangePassword: user.needChangePassword,
      token: user.token,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'] ?? 0,
      firstName: json['user']['first_name'] ?? '',
      lastName: json['user']['last_name'] ?? '',
      displayName: json['user']['display_name'] ?? '',
      email: json['user']['email'] ?? '',
      avatar: json['user']['avatar_url'] ?? '',
      needChangePassword: json['user']['need_update_pw'] == 1,
      token: json['access_token'] ?? '',
    );
  }
}
