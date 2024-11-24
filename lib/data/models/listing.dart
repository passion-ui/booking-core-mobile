import 'package:booking/domain/domain.dart';

class ListingModel<T> {
  final List<T> items;
  final int total;
  final int totalPages;

  ListingModel({
    required this.items,
    required this.total,
    required this.totalPages,
  });

  ListingEntity<T> toEntity() {
    return ListingEntity<T>(
      items: items,
      total: total,
      totalPages: totalPages,
    );
  }

  factory ListingModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ListingModel<T>(
      items: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      total: json['total'],
      totalPages: json['total_pages'],
    );
  }
}
