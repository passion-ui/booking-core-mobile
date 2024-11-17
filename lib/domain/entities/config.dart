import 'package:booking/domain/domain.dart';

class ConfigEntity {
  final String currency;
  final Map<String, BookingEntity> bookings;

  ConfigEntity({required this.currency, required this.bookings});
}
