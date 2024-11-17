import 'package:booking/domain/domain.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final List<BlockHomeEntity> data;

  HomeSuccess({required this.data});
}
