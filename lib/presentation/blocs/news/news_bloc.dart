import 'package:booking/presentation/presentation.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
