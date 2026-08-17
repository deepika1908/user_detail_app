import 'package:flutter/material.dart';

import '../../../../localization/app_string.dart';

class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.light,
    this.languageCode = 'en',
  });

  final ThemeMode themeMode;
  final String languageCode;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  String text(String key) => AppStringKeys.value[languageCode]?[key] ?? key;

  SettingsState copyWith({ThemeMode? themeMode, String? languageCode}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
