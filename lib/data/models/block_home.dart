import 'package:booking/domain/domain.dart';

class BlockHomeModel {
  final String title;
  final String description;

  BlockHomeModel({
    required this.title,
    required this.description,
  });

  BlockHomeEntity toEntity() {
    return BlockHomeEntity(
      title: title,
      description: description,
    );
  }

  factory BlockHomeModel.fromJson(Map<String, dynamic> json) {
    return BlockHomeModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
    );
  }
}
