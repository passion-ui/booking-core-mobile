class WishListEvent {}

class OnLoadWishList extends WishListEvent {
  final bool isLoadMore;

  OnLoadWishList({this.isLoadMore = false});
}
