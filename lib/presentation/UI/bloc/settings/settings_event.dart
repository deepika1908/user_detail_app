import 'package:flutter/material.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

final class ThemeModeChanged extends SettingsEvent {
  const ThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;
}

final class LanguageChanged extends SettingsEvent {
  const LanguageChanged(this.languageCode);

  final String languageCode;
}
