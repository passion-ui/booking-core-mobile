import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockSpaceModel extends BlockHomeModel {
  final List<ListingModel> items;
  final String style;

  BlockSpaceModel({
    required super.title,
    required super.description,
    required this.items,
    required this.style,
  });

  @override
  BlockHomeEntity toEntity() {
    ListingViewStyle style = ListingViewStyle.normal;
    if (this.style == 'grid') {
      style = ListingViewStyle.grid;
    } else if (this.style == 'list') {
      style = ListingViewStyle.list;
    }

    return BlockSpaceEntity(
      title: title,
      description: description,
      items: items.map((e) => e.toEntity()).toList(),
      style: style,
    );
  }

  factory BlockSpaceModel.fromJson(Map<String, dynamic> json) {
    return BlockSpaceModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      items: List<ListingModel>.from(
        json['model']['data'].map((item) => ListingModel.fromJson(item)),
      ),
      style: json['style'] ?? '',
    );
  }
}
