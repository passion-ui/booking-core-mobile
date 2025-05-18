import 'package:booking/domain/domain.dart';

class LoginUseCase {
  final AuthenticationRepositoryInterface repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({
    required String username,
    required String password,
  }) async {
    final user = await repository.login(username: username, password: password);
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

class ClearUserDataUseCase {
  final AuthenticationRepositoryInterface repository;

  ClearUserDataUseCase(this.repository);

  Future<void> call() async {
    return await repository.deleteUserData();
  }
}

class RegisterUseCase {
  final AuthenticationRepositoryInterface repository;

  RegisterUseCase(this.repository);

  Future<bool> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return await repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }
}

class ForgotPasswordUseCase {
  final AuthenticationRepositoryInterface repository;

  ForgotPasswordUseCase(this.repository);

  Future<bool> call({required String email}) async {
    return await repository.forgotPassword(email: email);
  }
}
