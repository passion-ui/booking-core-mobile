import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class BlockOffersModel extends BlockHomeModel {
  final List<OfferModel> offers;

  BlockOffersModel({
    required super.title,
    required super.description,
    required this.offers,
  });

  @override
  BlockHomeEntity toEntity() {
    return BlockOffersEntity(
      title: title,
      description: description,
      offers: offers.map((e) => e.toEntity()).toList(),
    );
  }

  factory BlockOffersModel.fromJson(Map<String, dynamic> json) {
    return BlockOffersModel(
      title: json['model']['title'] ?? '',
      description: json['model']['desc'] ?? json['model']['sub_title'] ?? '',
      offers: List<OfferModel>.from(
        json['model']['list_item'].map((item) => OfferModel.fromJson(item)),
      ),
    );
  }
}
