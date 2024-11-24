import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class WishListModel {
  final int id;
  final String createdAt;
  final String updatedAt;
  final ProductModel item;

  WishListModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.item,
  });

  WishListEntity toEntity() {
    return WishListEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      item: item.toEntity(),
    );
  }

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> service = json['service'] ?? {};
    service['object_model'] = json['object_model'];

    return WishListModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      item: ProductModel.fromJson(service),
    );
  }
}
