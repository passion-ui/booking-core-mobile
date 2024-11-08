import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  AuthenticationRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    return await _remoteDataSource.register(
      firstName,
      lastName,
      email,
      password,
    );
  }

  @override
  Future<bool> forgotPassword(String email) async {
    return await _remoteDataSource.forgotPassword(email);
  }

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
  Future<UserEntity?> getUserData() async {
    final user = await _localDataSource.getUserData();
    return user?.toEntity();
  }

  @override
  Future<void> deleteUserData() async {
    return await _localDataSource.deleteUserData();
  }
}
