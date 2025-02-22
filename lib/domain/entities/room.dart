import 'package:booking/domain/domain.dart';

class RoomEntity {
  final int id;
  final String title;
  final num price;
  final String size;
  final String bed;
  final String adults;
  final String children;
  final int quantity;
  int selected;
  final String image;
  final List<String> gallery;
  final String priceText;
  final List<ChildrenPropertiesEntity> features;

  RoomEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.size,
    required this.bed,
    required this.adults,
    required this.children,
    required this.quantity,
    this.selected = 0,
    required this.image,
    required this.gallery,
    required this.priceText,
    required this.features,
  });
}
