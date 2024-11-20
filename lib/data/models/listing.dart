import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ListingModel {
  final int id;
  final String title;
  final String image;
  final String content;
  final bool isFeatured;
  final num price;
  final num salePrice;
  final String saleOff;

  ListingModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.isFeatured,
    required this.price,
    required this.salePrice,
    required this.saleOff,
  });

  ListingEntity toEntity() {
    return ListingEntity(
      id: id,
      title: title,
      image: image,
      content: content,
      isFeatured: isFeatured,
      price: price,
      salePrice: salePrice,
      saleOff: saleOff,
    );
  }

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    switch (json['object_model']) {
      case 'hotel':
        return HotelModel.fromJson(json);

      case 'tour':
        return TourModel.fromJson(json);

      default:
        return ListingModel(
          id: json['id'] ?? 0,
          title: json['title'] ?? '',
          image: json['image'] ?? '',
          content: json['content'] ?? '',
          isFeatured: json['is_featured'] == 1,
          saleOff: json['discount_percent'] ?? '',
          price: num.tryParse(json['price'] ?? "") ?? 0,
          salePrice: num.tryParse(json['sale_price'] ?? "") ?? 0,
        );
    }
  }
}
