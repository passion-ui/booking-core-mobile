import 'package:booking/domain/domain.dart';

class ConfigEntity {
  final String currency;
  final List<BookingEntity> bookings;

  ConfigEntity({required this.currency, required this.bookings});
}
