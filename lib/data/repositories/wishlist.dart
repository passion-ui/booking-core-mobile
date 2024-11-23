import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class WishListRepository extends WishListRepositoryInterface {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  WishListRepository(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> getWishlist() {
    throw UnimplementedError();
  }
}
