import 'package:booking/domain/domain.dart';

class Login {
  final AuthenticationRepositoryInterface repository;

  Login(this.repository);

  Future<UserEntity?> call() async {
    return await repository.login();
  }
}
