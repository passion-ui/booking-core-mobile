import 'package:booking/domain/domain.dart';

class PackageModel {
  final String name;
  final String desc;
  final double price;
  final String type;

  PackageModel({
    required this.name,
    required this.desc,
    required this.price,
    required this.type,
  });

  PackageEntity toEntity() {
    return PackageEntity(
      name: name,
      desc: desc,
      price: price,
      type: type,
    );
  }

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      price: double.tryParse(json['price']) ?? 0.0,
      type: json['type'] ?? '',
    );
  }
}
