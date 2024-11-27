import 'package:booking/domain/domain.dart';

abstract class AuthenticationRepositoryInterface {
  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  );
  Future<bool> forgotPassword(String email);
  Future<UserEntity> login(String username, String password);
  Future<UserEntity?> getUserData();
  Future<void> saveUserData(UserEntity user);
  Future<void> deleteUserData();
}
