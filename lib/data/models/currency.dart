import 'package:booking/domain/domain.dart';

class CurrencyModel {
  final String main;
  final String symbol;

  CurrencyModel({
    required this.main,
    required this.symbol,
  });

  CurrencyEntity toEntity() {
    return CurrencyEntity(
      main: main,
      symbol: symbol,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'symbol': symbol,
    };
  }

  factory CurrencyModel.fromEntity(CurrencyEntity data) {
    return CurrencyModel(
      main: data.main,
      symbol: data.symbol,
    );
  }

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      main: json['currency_main'] ?? '',
      symbol: json['symbol'] ?? '',
    );
  }
}
