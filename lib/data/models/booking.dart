import 'package:booking/domain/domain.dart';

class BookingModel {
  final String id;
  final String name;
  final String icon;
  final List<String> searchFields;

  BookingModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.searchFields,
  });

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      name: name,
      icon: icon,
      searchFields: searchFields,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'searchFields': searchFields,
    };
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      searchFields: entity.searchFields,
    );
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      searchFields: List<String>.from(json['searchFields'] ?? []),
    );
  }
}
