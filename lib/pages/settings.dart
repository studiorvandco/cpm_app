import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  ThemeMode? themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Text('settings.settings'.tr(),
              textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const Padding(padding: EdgeInsets.only(bottom: 32)),
          Text('settings.theme.theme'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          const Padding(padding: EdgeInsets.only(bottom: 7)),
          Text('settings.theme.description'.tr(), textAlign: TextAlign.center),
          const Padding(padding: EdgeInsets.only(bottom: 7)),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Radio<ThemeMode>(
                        value: ThemeMode.light,
                        groupValue: themeMode,
                        onChanged: (ThemeMode? mode) {
                          setThemeMode(mode);
                        }),
                    Text('settings.theme.light'.tr())
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Radio<ThemeMode>(
                        value: ThemeMode.dark,
                        groupValue: themeMode,
                        onChanged: (ThemeMode? mode) {
                          setThemeMode(mode);
                        }),
                    Text('settings.theme.dark'.tr())
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Radio<ThemeMode>(
                        value: ThemeMode.system,
                        groupValue: themeMode,
                        onChanged: (ThemeMode? mode) {
                          setThemeMode(mode);
                        }),
                    Text('settings.theme.system'.tr())
                  ],
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 32)),
          Text('settings.language.language'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          const Padding(padding: EdgeInsets.only(bottom: 7)),
          Text('settings.language.description'.tr(), textAlign: TextAlign.center),
          const Padding(padding: EdgeInsets.only(bottom: 14)),
          SizedBox(
            width: 330,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text('settings.language.language'.tr()),
              items: context.supportedLocales.map<DropdownMenuItem<String>>((Locale value) {
                return DropdownMenuItem<String>(
                  value: value.toLanguageTag(),
                  child: Text('settings.language.${value.toLanguageTag()}'.tr()),
                );
              }).toList(),
              value: context.locale.toLanguageTag(),
              onChanged: (String? locale) {
                setLocale(locale);
              },
              decoration: InputDecoration(
                  labelText: 'settings.language.language'.tr(), border: const OutlineInputBorder(), isDense: true),
            ),
          ),
        ],
      )),
    );
  }

  void setThemeMode(ThemeMode? mode) {
    setState(() {
      themeMode = mode;
    });
    ref.read(themeProvider.notifier).set(themeMode);
  }

  void setLocale(String? locale) {
    if (locale != null) {
      final List<String> locales = locale.split('-');
      context.setLocale(Locale(locales[0], locales[1]));
    }
  }
}
