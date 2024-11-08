import 'package:booking/domain/domain.dart';

class ConfigModel {
  final String currency;

  ConfigModel({
    required this.currency,
  });

  ConfigEntity toEntity() {
    return ConfigEntity(
      currency: currency,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency_main': currency,
    };
  }

  factory ConfigModel.fromEntity(ConfigEntity config) {
    return ConfigModel(
      currency: config.currency,
    );
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      currency: json['currency_main'] ?? '',
    );
  }
}
