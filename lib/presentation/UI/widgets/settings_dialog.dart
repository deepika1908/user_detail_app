import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/language_provider.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/constants/app_icons.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: _buildHeader(languageProvider),
      content: SizedBox(
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeSection(themeProvider, languageProvider),

              const SizedBox(height: 20),

              _buildLanguageSection(languageProvider),
            ],
          ),
        ),
      ),
      actions: [
        _buildCloseButton(context, languageProvider),
      ],
    );
  }

  /// Header
  Widget _buildHeader(LanguageProvider languageProvider) {
    return Row(
      children: [
        const Icon(AppIcons.settings),
        const SizedBox(width: 10),
        Text(
          languageProvider.text("settings"),
          style: ScreenTextStyles.appBarTitle,
        ),
      ],
    );
  }

  /// Theme Section
  Widget _buildThemeSection(
    ThemeProvider themeProvider,
    LanguageProvider languageProvider,
  ) {
    return RadioGroup<bool>(
      groupValue: themeProvider.isDarkMode,
      onChanged: (value) {
        if (value != null) themeProvider.changeThemeMode(value);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.text("theme"),
            style: ScreenTextStyles.sectionTitle,
          ),
          const SizedBox(height: 10),
          _buildThemeTile(title: languageProvider.text("light"), value: false),
          _buildThemeTile(title: languageProvider.text("dark"), value: true),
        ],
      ),
    );
  }

  /// Theme Radio Tile
  Widget _buildThemeTile({
    required String title,
    required bool value,
  }) {
    return RadioListTile<bool>(
      title: Text(title),
      value: value,
    );
  }

  /// Language Section
  Widget _buildLanguageSection(
    LanguageProvider languageProvider,
  ) {
    return RadioGroup<String>(
      groupValue: languageProvider.currentLang,
      onChanged: (value) {
        if (value != null) languageProvider.changelang(value);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.text("language"),
            style: ScreenTextStyles.sectionTitle,
          ),
          const SizedBox(height: 10),
          _buildLanguageTile(title: languageProvider.text("english"), languageCode: "en"),
          _buildLanguageTile(title: languageProvider.text("arabic"), languageCode: "ar"),
        ],
      ),
    );
  }

  /// Language Radio Tile
  Widget _buildLanguageTile({
    required String title,
    required String languageCode,
  }) {
    return RadioListTile<String>(
      title: Text(title),
      value: languageCode,
    );
  }

  /// Close Button
  Widget _buildCloseButton(
    BuildContext context,
    LanguageProvider languageProvider,
  ) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        languageProvider.text("close"),
      ),
    );
  }
}
