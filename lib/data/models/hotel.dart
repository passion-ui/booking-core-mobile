import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class HotelModel extends ProductModel {
  final double? point;
  final List<FAQModel>? policies;
  final String? checkInTime;
  final String? checkOutTime;

  HotelModel({
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

    ///Specific
    this.point,
    this.policies,
    this.checkInTime,
    this.checkOutTime,
  });

  @override
  ProductEntity toEntity() {
    return HotelEntity(
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

      ///Specific
      point: point,
      policies: policies?.map((e) => e.toEntity()).toList(),
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
    );
  }

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);
    List<FAQModel>? policies;
    if (json['policy'] != null) {
      policies = List<FAQModel>.from(
        json['policy'].map(
          (item) => FAQModel.fromJson(item),
        ),
      );
    }

    return HotelModel(
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
      faqs: shared.faqs,
      related: shared.related,
      enableExtraPrice: shared.enableExtraPrice,
      extraServices: shared.extraServices,

      ///specific
      point: double.tryParse('${json['star_rate']}') ?? 0.0,
      policies: policies,
      checkInTime: json['check_in_time'] ?? '',
      checkOutTime: json['check_out_time'] ?? '',
    );
  }
}
