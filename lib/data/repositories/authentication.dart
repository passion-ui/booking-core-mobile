import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  AuthenticationRepository(this._remoteDataSource, this._localDataSource);

  @override
  Future<UserEntity?> login() async {
    // final user = await _httpClient.post(url: "auth/login", data: {});
    // if (user != null) {
    //   return user.toEntity();
    // }
    // return null;
  }
}
