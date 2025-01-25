import 'package:booking/domain/domain.dart';

class GetWishListUseCase {
  final WishListRepositoryInterface repository;

  GetWishListUseCase(this.repository);

  Future<ListingEntity<WishListEntity>> call({int? page}) async {
    return await repository.fetchWishList(page: page);
  }
}

class UpdateWishListUseCase {
  final WishListRepositoryInterface repository;

  UpdateWishListUseCase(this.repository);

  Future<bool> call(ProductEntity item) async {
    return await repository.updateWishList(item);
  }
}
