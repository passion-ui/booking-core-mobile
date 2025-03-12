import 'package:booking/domain/domain.dart';

class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final ProductEntity product;

  ProductDetailSuccess({required this.product});
}

class HotelDetailSuccess extends ProductDetailSuccess {
  final List<RoomEntity>? rooms;
  final DateTime startDate;
  final DateTime endDate;
  final int adults;
  final int children;
  bool useVIP;
  bool useBreakfast;

  HotelDetailSuccess({
    required super.product,
    this.rooms,
    required this.startDate,
    required this.endDate,
    required this.adults,
    required this.children,
    required this.useVIP,
    required this.useBreakfast,
  });
}

class SpaceDetailSuccess extends ProductDetailSuccess {
  final DateTime startDate;
  final DateTime endDate;
  final int adults;
  final int children;
  bool useGarden;
  bool useClean;
  bool useBreakfast;

  SpaceDetailSuccess({
    required super.product,
    required this.startDate,
    required this.endDate,
    required this.adults,
    required this.children,
    required this.useGarden,
    required this.useClean,
    required this.useBreakfast,
  });
}

class TourDetailSuccess extends ProductDetailSuccess {
  final DateTime startDate;
  final int adults;
  final int children;
  bool useClean;

  TourDetailSuccess({
    required super.product,
    required this.startDate,
    required this.adults,
    required this.children,
    required this.useClean,
  });
}

class CarDetailSuccess extends ProductDetailSuccess {
  final DateTime startDate;
  final DateTime endDate;
  final int number;
  final bool useToddlerSeat;
  final bool useInfantSeat;
  final bool useGpsSatellite;
  final String pickup;
  final String dropOff;

  CarDetailSuccess({
    required super.product,
    required this.startDate,
    required this.endDate,
    required this.number,
    required this.useToddlerSeat,
    required this.useInfantSeat,
    required this.useGpsSatellite,
    required this.pickup,
    required this.dropOff,
  });
}

class EventDetailSuccess extends ProductDetailSuccess {
  final DateTime startDate;
  final int vip;
  final int group;
  bool useService;

  EventDetailSuccess({
    required super.product,
    required this.startDate,
    required this.vip,
    required this.group,
    required this.useService,
  });
}

class BoatDetailSuccess extends ProductDetailSuccess {
  final DateTime startDate;
  final int hours;
  final int days;
  bool useToddlerSeat;
  bool useInfantSeat;
  bool useGpsSatellite;

  BoatDetailSuccess({
    required super.product,
    required this.hours,
    required this.startDate,
    required this.days,
    required this.useToddlerSeat,
    required this.useInfantSeat,
    required this.useGpsSatellite,
  });
}
