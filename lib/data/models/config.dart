import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ConfigModel {
  final String currency;
  final Map<String, BookingModel> bookings;

  ConfigModel({
    required this.currency,
    required this.bookings,
  });

  ConfigEntity toEntity() {
    return ConfigEntity(
      currency: currency,
      bookings: bookings.map(
        (key, value) => MapEntry(key, value.toEntity()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency_main': currency,
      'booking_types': bookings.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  factory ConfigModel.fromEntity(ConfigEntity config) {
    return ConfigModel(
      currency: config.currency,
      bookings: config.bookings.map(
        (key, value) => MapEntry(key, BookingModel.fromEntity(value)),
      ),
    );
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      currency: json['currency_main'] ?? '',
      bookings: (json['booking_types'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(
          key,
          BookingModel.fromJson(value),
        ),
      ),
    );
  }
}
