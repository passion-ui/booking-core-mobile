import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ConfigModel {
  final String currency;
  final List<BookingModel> bookings;

  ConfigModel({
    required this.currency,
    required this.bookings,
  });

  ConfigEntity toEntity() {
    return ConfigEntity(
      currency: currency,
      bookings: bookings.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency_main': currency,
      'booking_types': bookings.map((e) => e.toJson()).toList(),
    };
  }

  factory ConfigModel.fromEntity(ConfigEntity config) {
    return ConfigModel(
      currency: config.currency,
      bookings: config.bookings.map((e) => BookingModel.fromEntity(e)).toList(),
    );
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      currency: json['currency_main'] ?? '',
      bookings: List<BookingModel>.from(
        (json['booking_types'] ?? []).map(
          (i) => BookingModel.fromJson(i),
        ),
      ),
    );
  }
}
