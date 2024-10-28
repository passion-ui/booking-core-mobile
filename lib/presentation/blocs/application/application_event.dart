import 'package:booking/presentation/presentation.dart';

class ApplicationEvent {}

final class OnSetupApplication extends ApplicationEvent {}

final class OnChangeTheme extends ApplicationEvent {
  final String? font;
  final ThemeMode? themeMode;
  final Color? seedColor;
  OnChangeTheme({this.font, this.themeMode, this.seedColor});
}

final class OnChangeLanguage extends ApplicationEvent {
  final String language;

  OnChangeLanguage(this.language);
}
