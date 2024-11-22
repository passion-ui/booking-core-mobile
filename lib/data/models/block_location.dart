import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockLocationModel extends BlockHomeModel {
  final List<CategoryModel> items;

  BlockLocationModel({
    required super.title,
    required super.description,
    required this.items,
  });

  @override
  BlockHomeEntity toEntity() {
    return BlockLocationEntity(
      title: title,
      description: description,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  factory BlockLocationModel.fromJson(Map<String, dynamic> json) {
    return BlockLocationModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      items: List<CategoryModel>.from(
        json['model']['data'].map((item) => CategoryModel.fromJson(item)),
      ),
    );
  }
}
