import 'package:flutter/material.dart';

class ApplicationState {
  final String domain;
  final Locale language;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  ApplicationState({
    required this.domain,
    required this.language,
    required this.lightTheme,
    required this.darkTheme,
    this.themeMode = ThemeMode.system,
  });

  ApplicationState copyWith({
    String? domain,
    Locale? language,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
  }) {
    return ApplicationState(
      domain: domain ?? this.domain,
      language: language ?? this.language,
      lightTheme: lightTheme ?? this.lightTheme,
      darkTheme: darkTheme ?? this.darkTheme,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class ApplicationInitial extends ApplicationState {
  ApplicationInitial({
    required super.domain,
    required super.language,
    required super.lightTheme,
    required super.darkTheme,
    required super.themeMode,
  });
}

class ApplicationLoaded extends ApplicationState {
  ApplicationLoaded({
    required super.domain,
    required super.language,
    required super.lightTheme,
    required super.darkTheme,
    required super.themeMode,
  });
}
