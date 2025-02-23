import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class TourDetailCubit extends ProductDetailCubit {
  final _getDetailUseCase = GetDetailUseCase(sl());

  SpaceEntity? product;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));
  int adults = 1;
  int children = 0;
  bool garden = false;
  bool clean = false;
  bool breakfast = false;

  @override
  void onLoadDetail(ProductEntity item) async {
    try {
      final product = await _getDetailUseCase.call(item);
      emit(
        TourDetailSuccess(
          product: product,
          startDate: startDate,
          adults: adults,
          children: children,
          clean: clean,
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
    emit(TourDetailSuccess(
      product: product!,
      startDate: startDate,
      adults: adults,
      children: children,
      clean: clean,
    ));
  }
}
