import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 500);

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final _messageBloc = MessageBloc();
  final _getNewsUseCase = GetNewsUseCase(sl());

  int page = 1;
  ListingEntity<PostEntity>? data;

  NewsBloc() : super(NewsInitial()) {
    on<OnLoadNews>(
      (event, emit) async {
        if (event.isLoadMore) {
          page++;
        } else {
          page = 1;
        }
        try {
          final list = await _getNewsUseCase.call(
            page: page,
            keyword: event.keyword,
          );
          if (page == 1) {
            data = list;
          } else {
            data!.items.addAll(list.items);
          }
          emit(NewsSuccess(data: data!));
        } on Exception catch (error) {
          _messageBloc.add(
            OnMessage(title: error.toString().replaceAll("Exception: ", "")),
          );
        }
      },
      transformer: (events, mapper) {
        return events
            .debounce(const Duration(milliseconds: 500))
            .switchMap(mapper);
      },
    );
  }
}
