import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class RemoteDataSource {
  final HTTPClient _httpClient;
  final DeviceInfo _deviceInfo;

  final String _login = "/auth/login";

  RemoteDataSource(this._httpClient, this._deviceInfo);

  void setBaseUrl(String url) async {
    _httpClient.baseUrl = url;
  }

  Future<UserModel> login(String username, String password) async {
    final response = await _httpClient.post(
      url: _login,
      data: {
        "email": username,
        "password": password,
        "device_name": _deviceInfo.name,
      },
      loading: true,
    );
    if (response['status'] == 1) {
      return UserModel.fromJson(response);
    }
    throw Exception(response['message'] ?? "unknown_error");
  }
}
