import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:intl/intl.dart';

class HotelDetailCubit extends ProductDetailCubit {
  final _getDetailUseCase = GetDetailUseCase(sl());
  final _getAvailabilityUseCase = GetAvailabilityUseCase(sl());

  HotelEntity? product;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  int adults = 1;
  int children = 0;
  List<RoomEntity>? rooms = [];
  bool vip = false;
  bool breakfast = false;

  @override
  Future<void> onLoadDetail(ProductEntity item) async {
    try {
      final results = await Future.wait([
        _getDetailUseCase.call(item),
        _getAvailabilityUseCase.call(
          item: item as HotelEntity,
          startDate: DateFormat("yyyy-MM-dd").format(startDate),
          endDate: DateFormat("yyyy-MM-dd").format(endDate),
          adults: adults,
          children: children,
        ),
      ]);

      product = results[0] as HotelEntity;
      rooms = results[1] as List<RoomEntity>?;

      emit(HotelDetailSuccess(
        product: product!,
        rooms: rooms,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
        vip: vip,
        breakfast: breakfast,
      ));
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }

  ///Load availability room of hotel
  void checkAvailabilityRoom() async {
    try {
      rooms = null;
      emit(HotelDetailSuccess(
        product: product!,
        rooms: rooms,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
        vip: vip,
        breakfast: breakfast,
      ));
      rooms = await _getAvailabilityUseCase.call(
        item: product!,
        startDate: DateFormat("yyyy-MM-dd").format(startDate),
        endDate: DateFormat("yyyy-MM-dd").format(endDate),
        adults: adults,
        children: children,
      );

      emit(HotelDetailSuccess(
        product: product!,
        rooms: rooms,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
        vip: vip,
        breakfast: breakfast,
      ));
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }

  void updateCart(RoomEntity room) {
    emit(HotelDetailSuccess(
      product: product!,
      rooms: rooms,
      startDate: startDate,
      endDate: endDate,
      adults: adults,
      children: children,
      vip: vip,
      breakfast: breakfast,
    ));
  }
}
