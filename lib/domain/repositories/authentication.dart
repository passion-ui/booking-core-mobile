import 'package:booking/domain/domain.dart';

abstract class AuthenticationRepositoryInterface {
  Future<UserEntity> login(String username, String password);
  Future<UserEntity?> getUserData();
  Future<void> saveUserData(UserEntity user);
  Future<void> deleteUserData();
  Future<UserEntity?> verify();
}
