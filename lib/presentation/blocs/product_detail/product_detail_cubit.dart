import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final messageBloc = sl<MessageBloc>();
  final _getDetailUseCase = GetDetailUseCase(sl());

  ProductDetailCubit() : super(ProductDetailInitial());

  /// Load detail of product
  void onLoadDetail(ProductEntity item) async {
    try {
      final product = await _getDetailUseCase.call(item);
      emit(ProductDetailSuccess(product: product));
    } catch (error) {
      messageBloc.add(
        OnMessage(
          title: error.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }
}
