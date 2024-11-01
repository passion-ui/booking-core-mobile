import 'package:booking/domain/domain.dart';

abstract class AuthenticationRepositoryInterface {
  Future<UserEntity?> login();
}
