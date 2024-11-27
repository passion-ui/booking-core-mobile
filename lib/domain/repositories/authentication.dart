import 'package:booking/domain/domain.dart';

abstract class AuthenticationRepositoryInterface {
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
  Future<bool> forgotPassword({required String email});
  Future<UserEntity> login({
    required String username,
    required String password,
  });
  Future<UserEntity?> getUserData();
  Future<void> saveUserData(UserEntity user);
  Future<void> deleteUserData();
}
