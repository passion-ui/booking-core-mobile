import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class TourDetailCubit extends ProductDetailCubit {
  final _getDetailUseCase = GetDetailUseCase(sl());

  TourEntity? product;
  DateTime startDate = DateTime.now();
  int adults = 1;
  int children = 0;
  bool clean = false;

  @override
  void onLoadDetail(ProductEntity item) async {
    try {
      product = (await _getDetailUseCase.call(item)) as TourEntity;

      emit(
        TourDetailSuccess(
          product: product!,
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

  void updateCart() {
    emit(TourDetailSuccess(
      product: product!,
      startDate: startDate,
      adults: adults,
      children: children,
      clean: clean,
    ));
  }
}
