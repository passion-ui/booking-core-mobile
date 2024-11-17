import 'package:booking/domain/domain.dart';

class LocationModel {
  final int id;
  final String name;

  LocationModel({
    required this.id,
    required this.name,
  });

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
