import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ReviewModel {
  final double score;
  final int total;
  final String text;
  final List<RateScore>? rateScore;
  ReviewModel({
    required this.score,
    required this.total,
    required this.text,
    this.rateScore,
  });

  ReviewEntity toEntity() {
    return ReviewEntity(
      score: score,
      total: total,
      text: text,
      rateScore: rateScore?.map((rate) {
        return rate.toEntity();
      }).toList(),
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    List<RateScore>? rateScore;
    if (json['rate_score'] != null) {
      rateScore = Map.of(json['rate_score']).values.map((rateJson) {
        return RateScore.fromJson(rateJson);
      }).toList();
    }
    return ReviewModel(
      score: double.tryParse('${json['score_total']}') ?? 0.0,
      total: json['total_review'] ?? 0,
      text: json['review_text'] ?? json['score_text'] ?? '',
      rateScore: rateScore,
    );
  }
}
