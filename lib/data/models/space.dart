import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class SpaceModel extends ProductModel {
  final int guests;
  final int beds;
  final int bathrooms;
  final int squares;

  SpaceModel({
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
    required super.faqs,
    required super.related,
    required super.enableExtraPrice,
    required super.extraServices,
    required super.bookingFees,
    required this.guests,
    required this.beds,
    required this.bathrooms,
    required this.squares,
  });

  @override
  ProductEntity toEntity() {
    return SpaceEntity(
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
      faqs: faqs?.map((e) => e.toEntity()).toList(),
      related: related?.map((e) => e.toEntity()).toList(),
      enableExtraPrice: enableExtraPrice,
      extraServices: extraServices?.map((e) => e.toEntity()).toList(),
      bookingFees: bookingFees?.map((e) => e.toEntity()).toList(),

      ///Specific
      guests: guests,
      beds: beds,
      bathrooms: bathrooms,
      squares: squares,
    );
  }

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);

    return SpaceModel(
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
      feedbacks: shared.feedbacks,
      faqs: shared.faqs,
      related: shared.related,
      enableExtraPrice: shared.enableExtraPrice,
      extraServices: shared.extraServices,
      bookingFees: shared.bookingFees,
      guests: json['max_guests'] ?? 0,
      beds: json['bed'] ?? 0,
      bathrooms: json['bathroom'] ?? 0,
      squares: json['square'] ?? 0,
    );
  }
}
