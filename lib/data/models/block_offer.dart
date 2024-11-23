import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockOfferModel extends BlockHomeModel {
  final List<BannerModel> items;

  BlockOfferModel({
    required super.title,
    required super.description,
    required this.items,
  });

  @override
  BlockHomeEntity toEntity() {
    return BlockOfferEntity(
      title: title,
      description: description,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }

  factory BlockOfferModel.fromJson(Map<String, dynamic> json) {
    return BlockOfferModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      items: List<BannerModel>.from(
        json['model']['list_item'].map((item) => BannerModel.fromJson(item)),
      ),
    );
  }
}
