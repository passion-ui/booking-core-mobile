import 'package:booking/domain/domain.dart';

class LoginUseCase {
  final AuthenticationRepositoryInterface repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String username, String password) async {
    final user = await repository.login(username, password);
    await repository.saveUserData(user);
    return user;
  }
}

class GetUserDataUseCase {
  final AuthenticationRepositoryInterface repository;

  GetUserDataUseCase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getUserData();
  }
}

class AuthenticationVerifyUseCase {
  final AuthenticationRepositoryInterface repository;

  AuthenticationVerifyUseCase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.verify();
  }
}

class ClearUserDataUseCase {
  final AuthenticationRepositoryInterface repository;

  ClearUserDataUseCase(this.repository);

  Future<void> call() async {
    return await repository.deleteUserData();
  }
}
