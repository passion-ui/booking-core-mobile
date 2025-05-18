import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ListingCubit extends Cubit<ListingState> {
  final BookingEntity item;
  final _messageBloc = sl<MessageBloc>();
  final _loadListingUseCase = GetListingUseCase(sl());

  int page = 1;
  ListingEntity<ProductEntity>? data;
  ListingCubit({required this.item}) : super(ListingInitial()) {
    onLoad();
  }

  Future<void> onLoad({isLoadMore = false}) async {
    if (isLoadMore) {
      page++;
    } else {
      page = 1;
    }
    try {
      final list = await _loadListingUseCase.call(item: item, page: page);
      if (page == 1) {
        data = list;
      } else {
        data!.items.addAll(list.items);
      }
      emit(ListingSuccess(data: data!));
    } on Exception catch (error) {
      _messageBloc.add(
        OnMessage(title: error.toString().replaceAll("Exception: ", "")),
      );
    }
  }
}
