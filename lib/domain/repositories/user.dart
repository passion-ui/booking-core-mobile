import 'package:booking/domain/domain.dart';

abstract class UserRepositoryInterface {
  Future<UserEntity?> getUserStorage();
  Future<UserEntity?> getUserRemote();
}
