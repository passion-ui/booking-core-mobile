import 'package:booking/data/data.dart';
import 'package:booking/domain/domain.dart';

class ConfigModel {
  final CurrencyModel currency;
  final List<CurrencyModel> currencySupport;
  final Map<String, BookingModel> bookings;

  ConfigModel({
    required this.currency,
    required this.currencySupport,
    required this.bookings,
  });

  ConfigEntity toEntity() {
    return ConfigEntity(
      currency: currency.toEntity(),
      currencySupport: currencySupport.map((e) => e.toEntity()).toList(),
      bookings: bookings.map(
        (key, value) => MapEntry(key, value.toEntity()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency_main': currency.main,
      'currency': currencySupport.map((e) => e.toJson()).toList(),
      'booking_types': bookings.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  factory ConfigModel.fromEntity(ConfigEntity config) {
    return ConfigModel(
      currency: CurrencyModel.fromEntity(config.currency),
      currencySupport: config.currencySupport.map((e) {
        return CurrencyModel.fromEntity(e);
      }).toList(),
      bookings: config.bookings.map(
        (key, value) => MapEntry(key, BookingModel.fromEntity(value)),
      ),
    );
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    final currencySupport = List<CurrencyModel>.from(
      json['currency'].map((item) => CurrencyModel.fromJson(item)),
    );
    return ConfigModel(
      currency: currencySupport.firstWhere(
        (element) => element.main == json['currency_main'],
      ),
      currencySupport: currencySupport,
      bookings: (json['booking_types'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(
          key,
          BookingModel.fromJson(value),
        ),
      ),
    );
  }
}
