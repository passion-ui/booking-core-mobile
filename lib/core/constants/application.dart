import 'package:flutter/material.dart';

class Application {
  static const debug = true;
  static const domain = "https://sandbox.bookingcore.co";

  /// Date and Time Formats
  static const defaultDateFormat = 'yyyy-MM-dd';
  static const detailedDateFormat = 'HH:mm, MMM dd yyyy';

  /// App Store IDs
  static const playStoreID = "com.huynh.envato";
  static const appStoreID = "1526910309";

  /// External Links
  static const supportEmail = 'service@passionui.com';
  static const websiteUrl = 'https://saleboltapp.com';
  static const privacyPolicyUrl = 'https://saleboltapp.com/privacy';

  /// Sentry or other logging service DNS
  static const sentryDNS = '''
  https://7d14be39f77d8a8600ddc1e5b80ce908@o4505613750370304.ingest.sentry.io/4505613751746560
  ''';

  /// Theme App Settings
  static const defaultFontSize = 14.0;

  /// Font Family
  static const defaultFontFamily = 'Raleway';

  /// Font Weight
  static final fontFamilySupport = [
    "San Francisco",
    "OpenSans",
    "ProximaNova",
    "Raleway",
  ];

  /// Theme Color
  static final defaultTheme = {
    "title": "blue",
    "seedColor": '#2196F3',
  };

  /// Theme Support
  static final themeSupport = [
    {
      "title": "blue",
      "seedColor": '#2196F3',
    },
    {
      "title": "pink",
      "seedColor": '#E91E63',
    },
    {
      "title": "orange",
      "seedColor": '#FF9800',
    },
    {
      "title": "green",
      "seedColor": '#4CAF50',
    }
  ];

  /// Language Settings
  static const defaultLocale = Locale('en', 'US');

  /// Supported Locales
  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];
}
