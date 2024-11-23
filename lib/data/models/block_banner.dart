import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockBannerModel extends BlockHomeModel {
  final BannerModel item;

  BlockBannerModel({
    required super.title,
    required super.description,
    required this.item,
  });

  @override
  BlockHomeEntity toEntity() {
    return BlockBannerEntity(
      title: title,
      description: description,
      item: item.toEntity(),
    );
  }

  factory BlockBannerModel.fromJson(Map<String, dynamic> json) {
    return BlockBannerModel(
      title: '',
      description: '',
      item: BannerModel.fromJson(json['model']),
    );
  }
}
