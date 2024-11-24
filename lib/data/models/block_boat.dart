import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockBoatModel extends BlockHomeModel {
  final List<ProductModel> items;
  final String style;

  BlockBoatModel({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });

  @override
  BlockHomeEntity toEntity() {
    ListingViewStyle style = ListingViewStyle.card;
    if (this.style == 'grid') {
      style = ListingViewStyle.grid;
    } else if (this.style == 'list') {
      style = ListingViewStyle.list;
    }

    return BlockBoatEntity(
      title: title,
      description: description,
      items: items.map((e) => e.toEntity()).toList(),
      style: style,
    );
  }

  factory BlockBoatModel.fromJson(Map<String, dynamic> json) {
    return BlockBoatModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      items: List<ProductModel>.from(
        json['model']['data'].map((item) => ProductModel.fromJson(item)),
      ),
      style: json['style'] ?? '',
    );
  }
}
