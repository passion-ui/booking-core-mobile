import 'package:booking/core/core.dart';

class RemoteDataSource {
  final HTTPClient _httpClient;

  RemoteDataSource(this._httpClient);

  void setBaseUrl(String url) async {
    _httpClient.baseUrl = url;
  }
}
