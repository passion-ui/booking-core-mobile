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
      score: double.tryParse('${json['score_total']}') ?? 0.0,
      total: json['total_review'] ?? 0,
      text: json['review_text'] ?? '',
    );
  }
}
