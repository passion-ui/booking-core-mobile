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
  Future<UserEntity?> verify() async {
    ///TODO: Implement verify token user
    return null;
  }

  @override
  Future<void> saveUserData(UserEntity user) async {
    return await _localDataSource.saveUserData(UserModel.fromEntity(user));
  }

  @override
  Future<UserEntity> getUserData() async {
    final user = await _localDataSource.getUserData();
    return user.toEntity();
  }

  @override
  Future<void> deleteUserData() async {
    return await _localDataSource.deleteUserData();
  }
}
