import 'package:booking/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Translate {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  static const Iterable<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  Translate(this.locale);

  static Translate of(BuildContext context) {
    return Localizations.of<Translate>(context, Translate)!;
  }

  Future<bool> load() async {
    final jsonMap = await AssetUtils.loadJson(
      "assets/localizations/${locale.languageCode}.json",
    );

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translate> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return Application.supportedLocales.contains(locale);
  }

  @override
  Future<Translate> load(Locale locale) async {
    Translate localizations = Translate(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}
