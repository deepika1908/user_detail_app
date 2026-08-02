import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';

extension AppContext on BuildContext {
  LanguageProvider get language => read<LanguageProvider>();
  LanguageProvider get languageWatch => watch<LanguageProvider>();

  ThemeProvider get theme => read<ThemeProvider>();
  ThemeProvider get themeWatch => watch<ThemeProvider>();
}