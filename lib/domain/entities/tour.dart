import 'package:booking/domain/domain.dart';

class TourEntity extends ProductEntity {
  final String? duration;
  final CategoryEntity? category;
  final int? minPeople;
  final int? maxPeople;
  final List<String>? include;
  final List<String>? exclude;
  final List<ItineraryEntity>? itineraries;

  TourEntity({
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
    required this.duration,
    required this.category,
    required this.minPeople,
    required this.maxPeople,
    required this.include,
    required this.exclude,
    required this.itineraries,
  });
}
