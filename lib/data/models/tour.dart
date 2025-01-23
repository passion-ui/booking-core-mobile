import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class TourModel extends ProductModel {
  final String duration;

  TourModel({
    required super.id,
    required super.type,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.address,
    required super.location,
    required super.review,
    required super.banner,
    required super.gallery,
    required super.video,
    required super.gps,
    required super.properties,
    required this.duration,
  });

  @override
  ProductEntity toEntity() {
    return TourEntity(
      id: id,
      type: type,
      title: title,
      image: image,
      content: content,
      isFeatured: isFeatured,
      price: price,
      salePrice: salePrice,
      saleOff: saleOff,
      address: address,
      location: location.toEntity(),
      review: review.toEntity(),
      banner: banner,
      gallery: gallery,
      video: video,
      gps: gps?.toEntity(),
      properties: properties?.map((e) => e.toEntity()).toList(),

      ///Specific
      duration: duration,
    );
  }

  factory TourModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);

    return TourModel(
      id: shared.id,
      type: shared.type,
      title: shared.title,
      image: shared.image,
      content: shared.content,
      isFeatured: shared.isFeatured,
      price: shared.price,
      salePrice: shared.salePrice,
      saleOff: shared.saleOff,
      address: shared.address,
      location: shared.location,
      review: shared.review,
      banner: shared.banner,
      gallery: shared.gallery,
      video: shared.video,
      gps: shared.gps,
      properties: shared.properties,
      duration: json['duration'] ?? '',
    );
  }
}
