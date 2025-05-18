import 'package:booking/domain/domain.dart';

class ListingState {}

class ListingInitial extends ListingState {}

class ListingSuccess extends ListingState {
  final ListingEntity<ProductEntity> data;

  ListingSuccess({required this.data});
}
