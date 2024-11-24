import 'package:booking/domain/domain.dart';

class WishListEntity {
  final int id;
  final String createdAt;
  final String updatedAt;
  final ProductEntity item;

  WishListEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.item,
  });
}
