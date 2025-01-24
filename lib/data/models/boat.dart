import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BoatModel extends ProductModel {
  final int guests;
  final int cabins;
  final String length;
  final String speed;

  BoatModel({
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
    required super.feedbacks,
    required this.guests,
    required this.cabins,
    required this.length,
    required this.speed,
  });

  @override
  ProductEntity toEntity() {
    return BoatEntity(
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
      feedbacks: feedbacks?.map((e) => e.toEntity()).toList(),

      ///Specific
      guests: guests,
      cabins: cabins,
      length: length,
      speed: speed,
    );
  }

  factory BoatModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);
    return BoatModel(
      id: shared.id,
      type: shared.type,
      title: shared.title,
      image: shared.image,
      content: shared.content,
      isFeatured: shared.isFeatured,
      saleOff: shared.saleOff,
      price: shared.price,
      salePrice: shared.salePrice,
      address: shared.address,
      location: shared.location,
      review: shared.review,
      banner: shared.banner,
      gallery: shared.gallery,
      video: shared.video,
      gps: shared.gps,
      properties: shared.properties,
      feedbacks: shared.feedbacks,
      guests: json['max_guest'] ?? 0,
      cabins: json['cabin'] ?? 0,
      length: json['length'] ?? '',
      speed: json['speed'] ?? '',
    );
  }
}
