import 'package:booking/domain/domain.dart';

class ExtraServiceModel {
  final String name;
  final String type;
  final double price;

  ExtraServiceModel({
    required this.name,
    required this.type,
    required this.price,
  });

  ExtraServiceEntity toEntity() {
    return ExtraServiceEntity(
      name: name,
      type: type,
      price: price,
    );
  }

  factory ExtraServiceModel.fromJson(Map<String, dynamic> json) {
    return ExtraServiceModel(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? '',
    );
  }
}
