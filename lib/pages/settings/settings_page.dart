import 'package:cpm/l10n/app_localizations.g.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/string_extensions.dart';
import 'package:cpm/utils/locale_manager.dart';
import 'package:cpm/utils/package_info_manager.dart';
import 'package:cpm/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locale_names/locale_names.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _selectTheme(BuildContext context) {
    showAdaptiveDialog<ThemeMode>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          title: Text(localizations.settings_theme),
          children: [
            ListTile(
              leading: const Icon(Icons.smartphone),
              title: Text(localizations.settings_theme_system),
              onTap: () {
                context.pop(ThemeMode.system);
              },
            ),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(localizations.settings_theme_light),
              onTap: () {
                context.pop(ThemeMode.light);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(localizations.settings_theme_dark),
              onTap: () {
                context.pop(ThemeMode.dark);
              },
            ),
          ],
        );
      },
    ).then((themeMode) {
      ThemeManager().setThemeMode(themeMode);
      setState(() {});
    });
  }

  void _selectLanguage(BuildContext context) {
    showAdaptiveDialog<Locale>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          title: Text(localizations.settings_language),
          children: AppLocalizations.supportedLocales.map((locale) {
            return ListTile(
              title: Text(locale.nativeDisplayLanguage.capitalized),
              onTap: () {
                context.pop(locale);
              },
            );
          }).toList(),
        );
      },
    ).then((locale) {
      LocaleManager().setLocale(locale);
    });
  }

  void _openGitHub(_) {
    launchUrlString('https://github.com/studiorvandco/cpm_app');
  }

  void _openLicense(_) {
    launchUrlString('https://github.com/studiorvandco/cpm_app/blob/main/LICENSE');
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).colorScheme.background,
      ),
      darkTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).colorScheme.background,
      ),
      sections: [
        SettingsSection(
          title: Text(localizations.settings_appearance),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.palette),
              title: Text(localizations.settings_theme),
              value: Text(ThemeManager().themeModeName),
              onPressed: _selectTheme,
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: Text(localizations.settings_language),
              value: Text(Localizations.localeOf(context).nativeDisplayLanguage.capitalized),
              onPressed: _selectLanguage,
            ),
          ],
        ),
        SettingsSection(
          title: Text(localizations.settings_about),
          tiles: [
            SettingsTile(
              leading: const Icon(Icons.info),
              title: Text(PackageInfoManager().name),
              value: Text(PackageInfoManager().version),
            ),
            SettingsTile(
              leading: const Icon(SimpleIcons.github),
              title: Text(localizations.settings_github),
              value: Text(localizations.settings_github_description),
              onPressed: _openGitHub,
            ),
            SettingsTile(
              leading: const Icon(Icons.balance),
              title: Text(localizations.settings_licence),
              value: Text(localizations.settings_licence_description),
              onPressed: _openLicense,
            ),
          ],
        ),
      ],
    );
  }
}
