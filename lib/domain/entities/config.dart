import 'package:booking/domain/domain.dart';

class ConfigEntity {
  final CurrencyEntity currency;
  final List<CurrencyEntity> currencySupport;
  final Map<String, BookingEntity> bookings;

  ConfigEntity({
    required this.currencySupport,
    required this.currency,
    required this.bookings,
  });
}
