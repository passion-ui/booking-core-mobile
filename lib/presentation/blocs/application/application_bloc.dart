import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AuthenticationBloc _authenticationBloc;
  final _setupApplication = SetupApplicationUseCase(sl());
  final _updateApplication = UpdateApplicationUseCase(sl());

  Color _seedColor = ColorUtils.fromHex(
    Application.defaultTheme['seedColor'] ?? '',
  );

  ApplicationBloc(
    this._authenticationBloc,
  ) : super(_defaultState) {
    ///On Setup Application
    on<OnSetupApplication>((event, emit) async {
      final application = await _setupApplication.call();

      Locale? locale;

      final lightTheme = state.lightTheme;
      final darkTheme = state.darkTheme;
      final font = application?.font ?? Application.defaultFontFamily;
      ThemeMode themeMode = ThemeMode.system;

      if (application?.themeMode == ThemeMode.light.toString()) {
        themeMode = ThemeMode.light;
      } else if (application?.themeMode == ThemeMode.dark.toString()) {
        themeMode = ThemeMode.dark;
      }

      ColorScheme lightColorScheme = lightTheme.colorScheme;
      ColorScheme darkColorScheme = darkTheme.colorScheme;

      if (application?.language != null) {
        locale = Locale(application!.language);
      }

      if (application?.seedColor != null) {
        _seedColor = ColorUtils.fromHex(application!.seedColor);
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        );
      }

      emit(ApplicationLoaded(
        domain: state.domain,
        language: locale ?? state.language,
        lightTheme: ThemeUtils.createTheme(
          font: font,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeUtils.createTheme(
          font: font,
          colorScheme: darkColorScheme,
        ),
        themeMode: themeMode,
      ));

      ///Start event for authentication check
      _authenticationBloc.add(AuthenticationVerify());
    });

    ///On Change Theme
    on<OnChangeTheme>((event, emit) {
      final lightTheme = state.lightTheme;
      final darkTheme = state.darkTheme;
      final font = event.font ?? lightTheme.textTheme.titleLarge!.fontFamily!;
      final themeMode = event.themeMode ?? state.themeMode;

      ColorScheme lightColorScheme = lightTheme.colorScheme;
      ColorScheme darkColorScheme = darkTheme.colorScheme;

      if (event.seedColor != null) {
        _seedColor = event.seedColor!;
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: event.seedColor!,
          brightness: Brightness.light,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: event.seedColor!,
          brightness: Brightness.dark,
        );
      }

      emit(state.copyWith(
        lightTheme: ThemeUtils.createTheme(
          font: font,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeUtils.createTheme(
          font: font,
          colorScheme: darkColorScheme,
        ),
        themeMode: themeMode,
      ));

      _updateApplication.call(
        ApplicationEntity(
          domain: state.domain,
          language: state.language.languageCode,
          seedColor: _seedColor.value.toRadixString(16),
          font: font,
          themeMode: themeMode.toString(),
        ),
      );
    });

    ///On Change Language
    on<OnChangeLanguage>((event, emit) async {
      emit(state.copyWith(language: Locale(event.language)));
      _updateApplication.call(
        ApplicationEntity(
          domain: state.domain,
          language: event.language,
          seedColor: _seedColor.value.toRadixString(16),
          font: state.lightTheme.textTheme.titleLarge!.fontFamily!,
          themeMode: state.themeMode.toString(),
        ),
      );
    });
  }
}

final _defaultState = ApplicationInitial(
  domain: Application.domain,
  language: Application.defaultLocale,
  lightTheme: ThemeUtils.createTheme(
    font: Application.defaultFontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorUtils.fromHex(
        Application.defaultTheme['seedColor'] ?? '',
      ),
      brightness: Brightness.light,
    ),
  ),
  darkTheme: ThemeUtils.createTheme(
    font: Application.defaultFontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorUtils.fromHex(
        Application.defaultTheme['seedColor'] ?? '',
      ),
      brightness: Brightness.dark,
    ),
  ),
  themeMode: ThemeMode.system,
);
