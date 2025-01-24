import 'package:booking/domain/domain.dart';

class ReviewEntity {
  final double score;
  final int total;
  final String text;
  final List<RateScoreEntity>? rateScore;

  ReviewEntity({
    required this.score,
    required this.total,
    required this.text,
    this.rateScore,
  });
}
