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

      emit(HotelDetailSuccess(
        product: product!,
        rooms: results[1] as List<RoomEntity>?,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
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
      emit(HotelDetailSuccess(
        product: product!,
        rooms: null,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
      ));
      final results = await _getAvailabilityUseCase.call(
        item: product!,
        startDate: DateFormat("yyyy-MM-dd").format(startDate),
        endDate: DateFormat("yyyy-MM-dd").format(endDate),
        adults: adults,
        children: children,
      );

      emit(HotelDetailSuccess(
        product: product!,
        rooms: results,
        startDate: startDate,
        endDate: endDate,
        adults: adults,
        children: children,
      ));
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }
}
