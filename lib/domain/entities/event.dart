import 'package:booking/domain/domain.dart';

class EventEntity extends ProductEntity {
  final String duration;
  final String startTime;

  EventEntity({
    required super.id,
    required super.type,
    required super.title,
    required super.image,
    required super.content,
    required super.isFeatured,
    required super.price,
    required super.salePrice,
    required super.saleOff,
    required super.location,
    required super.review,
    required super.banner,
    required super.video,
    required super.gps,
    required this.duration,
    required this.startTime,
  });
}
