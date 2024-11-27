import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  AuthenticationRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    return await _remoteDataSource.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> forgotPassword({required String email}) async {
    return await _remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<UserEntity> login(
      {required String username, required String password}) async {
    final user = await _remoteDataSource.login(
      username: username,
      password: password,
    );
    return user.toEntity();
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
