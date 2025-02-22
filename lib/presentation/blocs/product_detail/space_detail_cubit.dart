import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class SpaceDetailCubit extends ProductDetailCubit {
  final _getDetailUseCase = GetDetailUseCase(sl());

  SpaceEntity? product;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  int adults = 1;
  int children = 0;
  bool vip = false;
  bool breakfast = false;

  @override
  void onLoadDetail(ProductEntity item) async {
    try {
      final product = await _getDetailUseCase.call(item);
      emit(
        SpaceDetailSuccess(
          product: product,
          startDate: startDate,
          endDate: endDate,
          adults: adults,
          children: children,
          vip: vip,
          breakfast: breakfast,
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

  void updateCart(RoomEntity room) {
    emit(SpaceDetailSuccess(
      product: product!,
      startDate: startDate,
      endDate: endDate,
      adults: adults,
      children: children,
      vip: vip,
      breakfast: breakfast,
    ));
  }
}
