import 'package:booking/domain/domain.dart';

class ConfigsState {}

class ConfigsInitial extends ConfigsState {}

class ConfigsSuccess extends ConfigsState {
  final ConfigEntity config;

  ConfigsSuccess({required this.config});
}
