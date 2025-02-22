import 'package:booking/domain/domain.dart';

class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductEntity product;

  ProductDetailSuccess({required this.product});
}

class HotelDetailSuccess extends ProductDetailSuccess {
  final List<RoomEntity>? rooms;
  final DateTime startDate;
  final DateTime endDate;
  final int adults;
  final int children;
  bool vip;
  bool breakfast;

  HotelDetailSuccess({
    required super.product,
    this.rooms,
    required this.startDate,
    required this.endDate,
    required this.adults,
    required this.children,
    required this.vip,
    required this.breakfast,
  });
}

class SpaceDetailSuccess extends ProductDetailSuccess {
  final DateTime startDate;
  final DateTime endDate;
  final int adults;
  final int children;
  bool vip;
  bool breakfast;

  SpaceDetailSuccess({
    required super.product,
    required this.startDate,
    required this.endDate,
    required this.adults,
    required this.children,
    required this.vip,
    required this.breakfast,
  });
}
