import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final _messageBloc = sl<MessageBloc>();
  final _loadWishListUseCase = GetWishListUseCase(sl());

  int page = 1;
  ListingEntity<WishListEntity>? data;

  WishListBloc() : super(WishListInitial()) {
    on<OnLoadWishList>((event, emit) async {
      if (event.isLoadMore) {
        page++;
      } else {
        page = 1;
      }
      try {
        final list = await _loadWishListUseCase.call(page);
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
    });
  }
}
