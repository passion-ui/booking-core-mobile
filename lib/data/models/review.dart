import 'package:booking/domain/domain.dart';

class ReviewModel {
  final double score;
  final int total;
  final String text;

  ReviewModel({
    required this.score,
    required this.total,
    required this.text,
  });

  ReviewEntity toEntity() {
    return ReviewEntity(
      score: score,
      total: total,
      text: text,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      score: json['score'] ?? 0.0,
      total: json['total'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}
