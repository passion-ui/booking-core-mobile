import 'package:booking/domain/domain.dart';

class ApplicationModel {
  final String language;
  final String font;
  final String seedColor;
  final String themeMode;

  ApplicationModel({
    required this.language,
    required this.seedColor,
    required this.font,
    required this.themeMode,
  });

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'seedColor': seedColor,
      'font': font,
      'themeMode': themeMode,
    };
  }

  ApplicationEntity toEntity() {
    return ApplicationEntity(
      language: language,
      seedColor: seedColor,
      font: font,
      themeMode: themeMode,
    );
  }

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      language: json['language'],
      seedColor: json['seedColor'],
      font: json['font'],
      themeMode: json['themeMode'],
    );
  }

  factory ApplicationModel.fromEntity(ApplicationEntity entity) {
    return ApplicationModel(
      language: entity.language,
      seedColor: entity.seedColor,
      font: entity.font,
      themeMode: entity.themeMode,
    );
  }
}
