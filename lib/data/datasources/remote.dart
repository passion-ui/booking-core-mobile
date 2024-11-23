import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class RemoteDataSource {
  final HTTPClient _httpClient;
  final DeviceInfo _deviceInfo;

  final String _configs = "/configs";
  final String _login = "/auth/login";
  final String _register = "/auth/register";
  final String _home = "/home-page";

  RemoteDataSource(this._httpClient, this._deviceInfo);

  void setBaseUrl(String url) async {
    _httpClient.baseUrl = url;
  }

  /// Get Configs
  Future<ConfigModel> getConfigs() async {
    final response = await _httpClient.get(
      url: _configs,
      loading: true,
    );
    if (response['status'] == 1) {
      return ConfigModel.fromJson(response);
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Register
  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final response = await _httpClient.post(
      url: _register,
      data: {
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "term": 1
      },
      loading: true,
    );
    if (response['status'] == true) {
      return true;
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Forgot Password
  Future<bool> forgotPassword(String email) async {
    throw Exception("Forgot Password Api missing");
  }

  /// Login
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

  /// Home
  Future<List<BlockHomeModel>> loadHome() async {
    final response = await _httpClient.get(
      url: _home,
    );
    if (response['status'] == 1) {
      return List.from(response['data'])
          .where((item) => item['open'] == true)
          .map((item) {
        final String type = item['type'];
        switch (type) {
          case 'form_search_all_service':
            return BlockServiceModel.fromJson(item);
          case 'offer_block':
            return BlockOfferModel.fromJson(item);
          case 'list_hotel':
            return BlockBestSellerModel.fromJson(item);
          case 'list_locations':
            return BlockLocationModel.fromJson(item);
          case 'list_tours':
            return BlockTourModel.fromJson(item);
          case 'list_space':
            return BlockSpaceModel.fromJson(item);
          case 'list_car':
            return BlockCarModel.fromJson(item);
          case 'list_event':
            return BlockEventModel.fromJson(item);
          case 'list_boat':
            return BlockBoatModel.fromJson(item);
          case 'list_news':
            return BlockPostModel.fromJson(item);
          case 'call_to_action':
            return BlockBannerModel.fromJson(item);
          default:
            return BlockHomeModel.fromJson(item);
        }
      }).toList();
    }
    throw Exception(response['message'] ?? "unknown_error");
  }
}
