import 'package:booking/domain/domain.dart';

class LoginUseCase {
  final AuthenticationRepositoryInterface repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String username, String password) async {
    return await repository.login(username, password);
  }
}

class AuthenticationVerifyUseCase {
  final AuthenticationRepositoryInterface repository;

  AuthenticationVerifyUseCase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.verify();
  }
}
