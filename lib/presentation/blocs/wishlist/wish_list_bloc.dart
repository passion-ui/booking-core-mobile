import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final _loadUseCase = GetWishListUseCase(sl());
  WishListBloc() : super(WishListInitial()) {
    on<OnLoadWishList>((event, emit) {});
  }
}
