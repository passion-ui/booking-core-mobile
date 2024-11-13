import 'package:booking/domain/domain.dart';

class BookingModel {
  final String name;
  final String icon;
  final List<String> searchFields;

  BookingModel({
    required this.name,
    required this.icon,
    required this.searchFields,
  });


  BookingEntity toEntity() {
    return BookingEntity(
      name: name,
      icon: icon,
      searchFields: searchFields,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'searchFields': searchFields,
    };
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      name: entity.name,
      icon: entity.icon,
      searchFields: entity.searchFields,
    );
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      searchFields: List<String>.from(json['searchFields'] ?? []),
    );
  }

}
