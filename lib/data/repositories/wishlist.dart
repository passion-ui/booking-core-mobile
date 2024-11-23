import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class WishListRepository extends WishListRepositoryInterface {
  final RemoteDataSource _remoteDataSource;

  WishListRepository(this._remoteDataSource);

  @override
  Future<void> fetch() async {
    await _remoteDataSource.fetchWishList();
  }
}
