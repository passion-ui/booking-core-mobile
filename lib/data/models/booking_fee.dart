import 'package:booking/domain/entities/entities.dart';

class BookingFeeModel {
  final String name;
  final String desc;
  final double price;
  final String type;

  BookingFeeModel({
    required this.name,
    required this.desc,
    required this.price,
    required this.type,
  });

  BookingFeeEntity toEntity() {
    return BookingFeeEntity(
      name: name,
      desc: desc,
      price: price,
      type: type,
    );
  }

  factory BookingFeeModel.fromJson(Map<String, dynamic> json) {
    return BookingFeeModel(
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      price: double.tryParse(json['price']) ?? 0.0,
      type: json['type'] ?? '',
    );
  }
}
