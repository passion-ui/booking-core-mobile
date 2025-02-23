import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class CarDetailCubit extends ProductDetailCubit {
  final _getDetailUseCase = GetDetailUseCase(sl());

  CarEntity? product;
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
      product = (await _getDetailUseCase.call(item)) as CarEntity;
      emit(
        CarDetailSuccess(
          product: product!,
          startDate: startDate,
          endDate: endDate,
          adults: adults,
          children: children,
          garden: garden,
          clean: clean,
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

  void updateCart() {
    emit(CarDetailSuccess(
      product: product!,
      startDate: startDate,
      endDate: endDate,
      adults: adults,
      children: children,
      garden: garden,
      clean: clean,
      breakfast: breakfast,
    ));
  }
}
