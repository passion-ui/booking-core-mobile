import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final _messageBloc = sl<MessageBloc>();
  final _loadWishListUseCase = GetWishListUseCase(sl());
  WishListBloc() : super(WishListInitial()) {
    on<OnLoadWishList>((event, emit) async {
      try {
        final list = await _loadWishListUseCase.call();
      } on Exception catch (error) {
        _messageBloc.add(
          OnMessage(title: error.toString().replaceAll("Exception: ", "")),
        );
      }
    });
  }
}
