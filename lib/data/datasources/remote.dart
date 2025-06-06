import 'package:booking/core/core.dart';
import 'package:booking/data/data.dart';

class RemoteDataSource {
  final HTTPClient _httpClient;
  final DeviceInfo _deviceInfo;

  final String _configs = "/configs";
  final String _login = "/auth/login";
  final String _register = "/auth/register";
  final String _home = "/home-page";
  final String _wishlist = "/user/wishlist";
  final String _news = "/news";
  final String _changePassword = "/auth/change-password";

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
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
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
  Future<bool> forgotPassword({required String email}) async {
    throw Exception("Forgot Password Api missing");
  }

  /// Login
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
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

  /// Fetch Wishlist
  Future<ListingModel<WishListModel>> fetchWishList({int? page = 1}) async {
    final response = await _httpClient.get(
      url: _wishlist,
      params: {"page": page},
    );
    if (response['status'] == 1) {
      return ListingModel.fromJson(
        response,
        (item) => WishListModel.fromJson(item),
      );
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Fetch Wishlist
  Future<ListingModel<PostModel>> fetchNews({
    int? page = 1,
    String? keyword,
  }) async {
    final response = await _httpClient.get(
      url: _news,
      params: {"page": page, "s": keyword},
    );
    if (response['status'] == 1) {
      return ListingModel.fromJson(
        response,
        (item) => PostModel.fromJson(item),
      );
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Fetch Product Detail
  Future<ProductModel> getProductDetail({
    required String type,
    required id,
  }) async {
    final response = await _httpClient.get(
      url: "/$type/detail/$id",
    );
    if (response['status'] == 1) {
      return ProductModel.fromJson(response['data']);
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Get Availability
  Future<List<RoomModel>?> getAvailability({
    required String type,
    required id,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
  }) async {
    final response = await _httpClient.get(
      url: "/$type/availability/$id",
      params: {
        "start_date": startDate,
        "end_date": endDate,
        "adults": adults,
        "firstLoad": false,
        "children": children
      },
    );
    if (response['status'] == 1) {
      return List.from(response['rooms']).map((item) {
        return RoomModel.fromJson(item);
      }).toList();
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Add/Remove to Wishlist
  Future<bool> updateWishList({
    required id,
    required type,
  }) async {
    final response = await _httpClient.post(
      url: _wishlist,
      data: {"object_id": id, 'object_model': type},
      loading: true,
    );
    if (response['status'] == 1) {
      return true;
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Fetch Filter Option
  Future<ProductModel> getFilterOptions(String type) async {
    final response = await _httpClient.get(
      url: "/$type/filters",
    );
    if (response['status'] == 1) {}
    throw Exception(response['message'] ?? "unknown_error");
  }

  /// Fetch Search List
  Future<ListingModel<ProductModel>> getListing({
    required String type,
    int? page,
  }) async {
    final response = await _httpClient.get(
      url: "/$type/search",
    );
    if (response['status'] == 1) {
      return ListingModel.fromJson(
        response,
        (item) => ProductModel.fromJson(item),
      );
    }
    throw Exception(response['message'] ?? "unknown_error");
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await _httpClient.post(
      url: _changePassword,
      data: {
        "current_password": oldPassword,
        "new_password": newPassword,
      },
      loading: true,
    );
    if (response['status'] != 1) {
      throw Exception("${response['message'] ?? "unknown_error"}");
    }
  }
}
