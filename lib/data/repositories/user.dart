import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<UserModel?> getUserStorage() async {}

  @override
  Future<UserModel?> getUserRemote() async {}
}
