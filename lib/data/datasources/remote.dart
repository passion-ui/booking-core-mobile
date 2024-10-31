import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class RemoteDataSource {
  final HTTPClient _httpClient;

  RemoteDataSource(this._httpClient);

  Future<UserModel?> getUser() {
    throw UnimplementedError();
  }
}
