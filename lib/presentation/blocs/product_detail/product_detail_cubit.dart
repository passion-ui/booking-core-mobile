import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final _getDetailUseCase = GetDetailUseCase(sl());

  ProductDetailCubit() : super(ProductDetailInitial());

  void onLoadDetail(ProductEntity item) {
    emit(ProductDetailSuccess(product: item));
  }
}
