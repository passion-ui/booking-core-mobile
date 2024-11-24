import 'package:booking/domain/domain.dart';

class WishListState {}

class WishListInitial extends WishListState {}

class WishListSuccess extends WishListState {
  final ListingEntity<WishListEntity> data;

  WishListSuccess({required this.data});
}
