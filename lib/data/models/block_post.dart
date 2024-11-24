import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockPostModel extends BlockHomeModel {
  final List<PostModel> items;
  final String style;

  BlockPostModel({
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

    return BlockPostEntity(
      title: title,
      description: description,
      items: items.map((e) => e.toEntity()).toList(),
      style: style,
    );
  }

  factory BlockPostModel.fromJson(Map<String, dynamic> json) {
    return BlockPostModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      items: List<PostModel>.from(
        json['model']['data'].map((item) => PostModel.fromJson(item)),
      ),
      style: json['style'] ?? '',
    );
  }
}
