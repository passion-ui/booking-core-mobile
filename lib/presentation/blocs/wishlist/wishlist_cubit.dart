import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class WishListCubit extends Cubit<WishListState> {
  final _messageBloc = sl<MessageBloc>();
  final _loadWishListUseCase = GetWishListUseCase(sl());

  int page = 1;
  ListingEntity<WishListEntity>? data;

  WishListCubit() : super(WishListInitial());

  Future<void> onLoad({isLoadMore = false}) async {
    if (isLoadMore) {
      page++;
    } else {
      page = 1;
    }
    try {
      final list = await _loadWishListUseCase.call(page: page);
      if (page == 1) {
        data = list;
      } else {
        data!.items.addAll(list.items);
      }
      emit(WishListSuccess(data: data!));
    } on Exception catch (error) {
      _messageBloc.add(
        OnMessage(title: error.toString().replaceAll("Exception: ", "")),
      );
    }
  }
}
