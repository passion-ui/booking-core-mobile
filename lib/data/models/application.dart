import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';

class ApplicationModel {
  final String domain;
  final String language;
  final String font;
  final String seedColor;
  final String themeMode;

  ApplicationModel({
    required this.domain,
    required this.language,
    required this.seedColor,
    required this.font,
    required this.themeMode,
  });

  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'language': language,
      'seedColor': seedColor,
      'font': font,
      'themeMode': themeMode,
    };
  }

  ApplicationEntity toEntity() {
    return ApplicationEntity(
      domain: domain,
      language: language,
      seedColor: seedColor,
      font: font,
      themeMode: themeMode,
    );
  }

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      domain: json['domain'] ?? Application.domain,
      language: json['language'] ?? Application.defaultLocale.languageCode,
      seedColor: json['seedColor'] ?? Application.defaultTheme['seedColor']!,
      font: json['font'] ?? Application.defaultFontFamily,
      themeMode: json['themeMode'] ?? "",
    );
  }

  factory ApplicationModel.fromEntity(ApplicationEntity entity) {
    return ApplicationModel(
      domain: entity.domain,
      language: entity.language,
      seedColor: entity.seedColor,
      font: entity.font,
      themeMode: entity.themeMode,
    );
  }
}
