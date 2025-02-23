import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class CarDetailCubit extends ProductDetailCubit {
  final _getDetailUseCase = GetDetailUseCase(sl());

  CarEntity? product;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  int number = 0;
  bool childSeat = false;
  bool infantSeat = false;
  bool gpsSatellite = false;
  String pickup = "";
  String dropOff = "";

  @override
  void onLoadDetail(ProductEntity item) async {
    try {
      product = (await _getDetailUseCase.call(item)) as CarEntity;
      emit(
        CarDetailSuccess(
          product: product!,
          startDate: startDate,
          endDate: endDate,
          number: number,
          childSeat: childSeat,
          infantSeat: infantSeat,
          gpsSatellite: gpsSatellite,
          pickup: pickup,
          dropOff: dropOff,
        ),
      );
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }

  void updateCart() {
    emit(CarDetailSuccess(
      product: product!,
      startDate: startDate,
      endDate: endDate,
      number: number,
      childSeat: childSeat,
      infantSeat: infantSeat,
      gpsSatellite: gpsSatellite,
      pickup: pickup,
      dropOff: dropOff,
    ));
  }
}
