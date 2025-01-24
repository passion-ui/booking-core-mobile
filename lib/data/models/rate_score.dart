import 'package:booking/domain/domain.dart';

class RateScore {
  final String title;
  final int total;
  final int percent;

  RateScore({
    required this.title,
    required this.total,
    required this.percent,
  });

  RateScoreEntity toEntity() {
    return RateScoreEntity(
      title: title,
      total: total,
      percent: percent,
    );
  }

  factory RateScore.fromJson(Map<String, dynamic> json) {
    return RateScore(
      title: json['title'] ?? '',
      total: json['total'] ?? 0,
      percent: json['percent'] ?? 0,
    );
  }
}
