import 'package:booking/data/data.dart';
import 'package:booking/data/models/boat.dart';
import 'package:booking/domain/domain.dart';

class ProductModel {
  final int id;
  final String type;
  final String title;
  final String image;
  final String content;
  final bool isFeatured;
  final num price;
  final num salePrice;
  final String saleOff;
  final String address;
  final CategoryModel location;
  final ReviewModel review;
  final String? banner;
  final List<String> gallery;
  final String? video;
  final GPSModel? gps;
  final List<ProductPropertiesModel>? properties;
  final List<FeedbackModel>? feedbacks;
  final List<FAQModel>? faqs;
  final List<ProductModel>? related;
  final bool? enableExtraPrice;
  final List<ExtraServiceModel>? extraServices;
  final List<PackageModel>? bookingFees;

  ProductModel({
    required this.id,
    required this.title,
    required this.type,
    required this.image,
    required this.content,
    required this.isFeatured,
    required this.price,
    required this.salePrice,
    required this.saleOff,
    required this.address,
    required this.location,
    required this.review,
    required this.banner,
    required this.gallery,
    required this.video,
    required this.gps,
    required this.properties,
    required this.feedbacks,
    required this.faqs,
    required this.related,
    required this.enableExtraPrice,
    required this.extraServices,
    required this.bookingFees,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      type: type,
      image: image,
      gallery: gallery,
      content: content,
      isFeatured: isFeatured,
      price: price,
      salePrice: salePrice,
      saleOff: saleOff,
      address: address,
      location: location.toEntity(),
      review: review.toEntity(),
      banner: banner,
      video: video,
      gps: gps?.toEntity(),
      properties: properties?.map((e) => e.toEntity()).toList(),
      feedbacks: feedbacks?.map((e) => e.toEntity()).toList(),
      faqs: faqs?.map((e) => e.toEntity()).toList(),
      related: related?.map((e) => e.toEntity()).toList(),
      enableExtraPrice: enableExtraPrice,
      extraServices: extraServices?.map((e) => e.toEntity()).toList(),
      bookingFees: bookingFees?.map((e) => e.toEntity()).toList(),
    );
  }

  static ProductModel shared(Map<String, dynamic> json) {
    GPSModel? gps;
    List<ProductPropertiesModel>? properties;
    List<FeedbackModel>? feedbacks;
    List<FAQModel>? faqs;
    List<ProductModel>? related;
    List<ExtraServiceModel>? extraServices;
    List<PackageModel>? bookingFees;

    if (json['map_lat'] != null && json['map_lng'] != null) {
      gps = GPSModel(
        title: json['title'] ?? '',
        latitude: double.tryParse(json['map_lat']) ?? 0.0,
        longitude: double.tryParse(json['map_lng']) ?? 0.0,
        zoom: double.tryParse('${json['map_zoom']}') ?? 12.0,
      );
    }

    if (json['terms'] != null) {
      properties = Map.of(json['terms']).values.map((item) {
        return ProductPropertiesModel.fromJson(item);
      }).toList();
    }

    if (json['review_lists'] != null && json['review_lists']['data'] != null) {
      feedbacks = List.from(json['review_lists']['data']).map((item) {
        return FeedbackModel.fromJson(item);
      }).toList();
    }

    if (json['faqs'] != null) {
      faqs = List.from(json['faqs']).map((item) {
        return FAQModel.fromJson(item);
      }).toList();
    }

    if (json['related'] != null) {
      related = List.from(json['related']).map((item) {
        return ProductModel.fromJson(item);
      }).toList();
    }

    if (json['extra_services'] != null) {
      extraServices = List.from(json['extra_services']).map((item) {
        return ExtraServiceModel.fromJson(item);
      }).toList();
    }

    if (json['booking_fee'] != null) {
      bookingFees = List.from(json['booking_fee']).map((item) {
        return PackageModel.fromJson(item);
      }).toList();
    }

    return ProductModel(
      id: json['id'] ?? 0,
      type: json['object_model'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      gallery: List<String>.from(json['gallery'] ?? []),
      content: json['content'] ?? '',
      isFeatured: json['is_featured'] == 1,
      saleOff: json['discount_percent'] ?? '',
      price: num.tryParse('${json['price']}') ?? 0,
      salePrice: num.tryParse('${json['sale_price']}') ?? 0,
      address: json['address'] ?? '',
      location: CategoryModel.fromJson(json['location']),
      review: ReviewModel.fromJson(json['review_score']),
      banner: json['banner_image'],
      video: json['video'],
      gps: gps,
      properties: properties,
      feedbacks: feedbacks,
      faqs: faqs,
      related: related,
      enableExtraPrice: json['enable_extra_price'] == 1,
      extraServices: extraServices,
      bookingFees: bookingFees,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    switch (json['object_model']) {
      case 'hotel':
        return HotelModel.fromJson(json);

      case 'tour':
        return TourModel.fromJson(json);

      case 'space':
        return SpaceModel.fromJson(json);

      case 'car':
        return CarModel.fromJson(json);

      case 'event':
        return EventModel.fromJson(json);

      case 'boat':
        return BoatModel.fromJson(json);

      default:
        return shared(json);
    }
  }
}
