import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';

class AppContext {
  AppContext(this.context);

  final BuildContext context;

  LanguageProvider get language => context.read<LanguageProvider>();
  LanguageProvider get languageWatch => context.watch<LanguageProvider>();

  ThemeProvider get theme => context.read<ThemeProvider>();
  ThemeProvider get themeWatch => context.watch<ThemeProvider>();
}