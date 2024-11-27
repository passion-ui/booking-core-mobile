import 'package:booking/core/core.dart';
import 'package:booking/domain/domain.dart';
import 'package:booking/presentation/presentation.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  ///On Show Picker Language
  void _onLanguage(BuildContext context) async {
    final data = await showModalBottomSheet<List?>(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        Locale locale = Localizations.localeOf(context);
        return BottomSheetSelect(
          title: Translate.of(context).translate('language'),
          items: Application.supportedLocales.map((e) {
            return PickerEntity(
              id: e.languageCode,
              leading: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(Images.getImage(e.languageCode)),
                  ),
                ),
              ),
              title: Translate.of(context).translate(e.languageCode),
            );
          }).toList(),
          multiples: false,
          selected: [
            PickerEntity(
              id: locale.languageCode,
              leading: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(Images.getImage(locale.languageCode)),
                  ),
                ),
              ),
              title: Translate.of(context).translate(locale.languageCode),
            )
          ],
        );
      },
    );

    if (data != null && context.mounted) {
      final bloc = context.read<ApplicationBloc>();
      bloc.add(OnChangeLanguage(data.first.id));
    }
  }

  ///On Show Picker Font
  void _onFont(BuildContext context) async {
    final data = await showModalBottomSheet<List?>(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        String font = Theme.of(context).textTheme.titleLarge!.fontFamily!;
        return BottomSheetSelect(
          title: Translate.of(context).translate('font'),
          items: Application.fontFamilySupport.map((e) {
            return PickerEntity(
              id: e,
              title: e,
            );
          }).toList(),
          multiples: false,
          selected: [
            PickerEntity(
              id: font,
              title: font,
            )
          ],
        );
      },
    );

    if (data != null && context.mounted) {
      final bloc = context.read<ApplicationBloc>();
      bloc.add(OnChangeTheme(font: data.first.id));
    }
  }

  ///On Change Dark Option
  void _onChangeDarkOption(BuildContext context) async {
    final state = context.read<ApplicationBloc>().state;
    ThemeMode? themeMode = state.themeMode;
    final result = await showDialog<ThemeMode?>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(Translate.of(context).translate('dark_mode')),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    RadioListTile<ThemeMode>(
                      title: Text(Translate.of(context).translate('light')),
                      value: ThemeMode.light,
                      groupValue: themeMode,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          themeMode = value;
                        });
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(Translate.of(context).translate('dark')),
                      value: ThemeMode.dark,
                      groupValue: themeMode,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          themeMode = value;
                        });
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(Translate.of(context).translate('system')),
                      value: ThemeMode.system,
                      groupValue: themeMode,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (ThemeMode? value) {
                        setState(() {
                          themeMode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(Translate.of(context).translate('cancel')),
                  onPressed: () {
                    context.pop();
                  },
                ),
                FilledButton(
                  child: Text(Translate.of(context).translate('apply')),
                  onPressed: () {
                    context.pop(themeMode);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null && context.mounted) {
      final bloc = context.read<ApplicationBloc>();
      bloc.add(OnChangeTheme(themeMode: result));
    }
  }

  ///On Show Picker Language
  void _onTheme(BuildContext context) async {
    final data = await showModalBottomSheet<List?>(
      context: context,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return BottomSheetSelect(
          title: Translate.of(context).translate('theme'),
          items: Application.themeSupport.map((e) {
            ColorScheme colorScheme = ColorScheme.fromSeed(
              seedColor: ColorUtils.fromHex(e["seedColor"] ?? ""),
            );
            return PickerEntity(
              id: colorScheme.primary.value.toRadixString(16),
              title: Translate.of(context).translate(e["title"] as String),
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              data: ColorUtils.fromHex(e["seedColor"] ?? ""),
            );
          }).toList(),
          multiples: false,
          selected: [
            PickerEntity(
              id: Theme.of(context).colorScheme.primary.value.toRadixString(16),
              title: Theme.of(context).colorScheme.primary.toString(),
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )
          ],
        );
      },
    );

    if (data != null && context.mounted) {
      final bloc = context.read<ApplicationBloc>();
      bloc.add(OnChangeTheme(seedColor: data.first.data));
    }
  }

  @override
  Widget build(BuildContext context) {
    final application = context.read<ApplicationBloc>().state;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('settings'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.language,
                        color: Colors.blue,
                      ),
                    ),
                    description: Translate.of(context).translate(
                      application.language.languageCode,
                    ),
                    descriptionPosition: DescriptionPosition.right,
                    title: Translate.of(context).translate('language'),
                    onPress: () => _onLanguage(context),
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.color_lens_outlined,
                        color: Colors.purple,
                      ),
                    ),
                    title: Translate.of(context).translate('theme'),
                    description: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    descriptionPosition: DescriptionPosition.right,
                    onPress: () => _onTheme(context),
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.indigo.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.indigo,
                      ),
                    ),
                    description: Translate.of(context).translate(
                      application.themeMode.toString(),
                    ),
                    descriptionPosition: DescriptionPosition.right,
                    title: Translate.of(context).translate('dark_mode'),
                    onPress: () => _onChangeDarkOption(context),
                  ),
                  SizedBox(height: 12),
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.text_format,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    description:
                        Theme.of(context).textTheme.titleLarge!.fontFamily,
                    descriptionPosition: DescriptionPosition.right,
                    title: Translate.of(context).translate('font'),
                    onPress: () => _onFont(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Box(
              child: Column(
                children: [
                  ListTitle(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withAlpha(80),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.domain,
                        color: Colors.cyan,
                      ),
                    ),
                    description: application.domain,
                    descriptionPosition: DescriptionPosition.right,
                    title: Translate.of(context).translate('domain'),
                    onPress: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
