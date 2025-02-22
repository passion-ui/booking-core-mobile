import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class RoomModel {
  final int id;
  final String title;
  final num price;
  final String size;
  final String bed;
  final String adults;
  final String children;
  final int quantity;
  final String image;
  final List<String> gallery;
  final String priceText;
  final List<ChildrenProperties> features;

  RoomModel({
    required this.id,
    required this.title,
    required this.price,
    required this.size,
    required this.bed,
    required this.adults,
    required this.children,
    required this.quantity,
    required this.image,
    required this.gallery,
    required this.priceText,
    required this.features,
  });

  RoomEntity toEntity() {
    return RoomEntity(
      id: id,
      title: title,
      price: price,
      size: size,
      bed: bed,
      adults: adults,
      children: children,
      quantity: quantity,
      image: image,
      gallery: gallery,
      priceText: priceText,
      features: features.map((e) => e.toEntity()).toList(),
    );
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: num.tryParse('${json['price']}') ?? 0,
      size: json['size_html'] ?? '',
      bed: json['beds_html'] ?? '',
      adults: json['adults_html'] ?? '',
      children: json['children_html'] ?? '',
      quantity: json['number'] ?? 0,
      image: json['image'] ?? '',
      gallery: List.from(json['gallery'] ?? []).map((item) {
        return item['large'] as String;
      }).toList(),
      priceText: json['price_text'] ?? '',
      features: List.from(json['term_features'] ?? []).map((item) {
        return ChildrenProperties.fromJson(item);
      }).toList(),
    );
  }
}
