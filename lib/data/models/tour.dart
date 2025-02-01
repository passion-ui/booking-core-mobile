import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class TourModel extends ProductModel {
  final String? duration;
  final CategoryModel? category;
  final int? minPeople;
  final int? maxPeople;
  final List<String>? include;
  final List<String>? exclude;
  final List<ItineraryModel>? itineraries;

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
    required super.feedbacks,
    required super.faqs,
    required super.related,
    required super.enableExtraPrice,
    required super.extraServices,
    required this.duration,
    required this.category,
    required this.minPeople,
    required this.maxPeople,
    required this.include,
    required this.exclude,
    required this.itineraries,
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
      feedbacks: feedbacks?.map((e) => e.toEntity()).toList(),
      faqs: faqs?.map((e) => e.toEntity()).toList(),
      related: related?.map((e) => e.toEntity()).toList(),
      enableExtraPrice: enableExtraPrice,
      extraServices: extraServices?.map((e) => e.toEntity()).toList(),

      ///Specific
      duration: duration,
      category: category?.toEntity(),
      minPeople: minPeople,
      maxPeople: maxPeople,
      include: include,
      exclude: exclude,
      itineraries: itineraries?.map((e) => e.toEntity()).toList(),
    );
  }

  factory TourModel.fromJson(Map<String, dynamic> json) {
    final shared = ProductModel.shared(json);
    CategoryModel? category;
    List<String>? include;
    List<String>? exclude;
    List<ItineraryModel>? itineraries;

    if (json['category'] != null) {
      category = CategoryModel.fromJson(json['category']);
    }
    if (json['include'] != null) {
      include = List<String>.from(json['include'].map((item) => item['title']));
    }
    if (json['exclude'] != null) {
      exclude = List<String>.from(json['exclude'].map((item) => item['title']));
    }
    if (json['itinerary'] != null) {
      itineraries = List<ItineraryModel>.from(
        json['itinerary'].map((item) => ItineraryModel.fromJson(item)),
      );
    }

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
      feedbacks: shared.feedbacks,
      faqs: shared.faqs,
      related: shared.related,
      enableExtraPrice: shared.enableExtraPrice,
      extraServices: shared.extraServices,

      ///Specific
      duration: json['duration'],
      category: category,
      minPeople: json['min_people'],
      maxPeople: json['max_people'],
      include: include,
      exclude: exclude,
      itineraries: itineraries,
    );
  }
}
