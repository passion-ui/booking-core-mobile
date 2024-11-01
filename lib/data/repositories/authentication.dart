import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  AuthenticationRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<UserEntity> login(String username, String password) async {
    final user = await _remoteDataSource.login(username, password);
    return user.toEntity();
  }

  @override
  Future<UserEntity?> verify() {
    throw UnimplementedError();
  }
}
