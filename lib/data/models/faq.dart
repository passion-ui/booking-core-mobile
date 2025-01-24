import 'package:booking/domain/domain.dart';

class FAQModel {
  final String title;
  final String content;

  FAQModel({
    required this.title,
    required this.content,
  });

  FAQEntity toEntity() {
    return FAQEntity(
      title: title,
      content: content,
    );
  }

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
