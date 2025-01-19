import 'package:booking/domain/domain.dart';

class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductEntity product;

  ProductDetailSuccess({required this.product});
}
