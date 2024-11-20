import 'package:booking/domain/domain.dart';

class LocationModel {
  final int id;
  final String name;
  final String image;

  LocationModel({
    required this.id,
    required this.name,
    required this.image,
  });

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
      image: image,
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
