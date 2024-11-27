import 'package:booking/domain/domain.dart';

class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final ListingEntity<PostEntity> data;

  NewsSuccess({
    required this.data,
  });
}
