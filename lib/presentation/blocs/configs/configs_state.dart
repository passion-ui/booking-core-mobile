import 'package:booking/domain/domain.dart';

class ConfigsState {}

class ConfigsInitial extends ConfigsState {}

class ConfigsSuccess extends ConfigsState {
  final ConfigEntity data;

  ConfigsSuccess({required this.data});
}
