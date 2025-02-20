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

  HotelDetailSuccess({
    required super.product,
    this.rooms,
    required this.startDate,
    required this.endDate,
    required this.adults,
    required this.children,
  });
}
