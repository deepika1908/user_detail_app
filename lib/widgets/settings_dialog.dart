import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';

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
        const Icon(Icons.settings),
        const SizedBox(width: 10),
        Text(
          languageProvider.text("settings"),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Theme Section
  Widget _buildThemeSection(
    ThemeProvider themeProvider,
    LanguageProvider languageProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.text("theme"),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        _buildThemeTile(
          title: languageProvider.text("light"),
          value: false,
          provider: themeProvider,
        ),

        _buildThemeTile(
          title: languageProvider.text("dark"),
          value: true,
          provider: themeProvider,
        ),
      ],
    );
  }

  /// Theme Radio Tile
  Widget _buildThemeTile({
    required String title,
    required bool value,
    required ThemeProvider provider,
  }) {
    return RadioListTile<bool>(
      title: Text(title),
      value: value,
      groupValue: provider.isDarkMode,
      onChanged: (value) {
        if (value != null) {
          provider.changeThemeMode(value);
        }
      },
    );
  }

  /// Language Section
  Widget _buildLanguageSection(
    LanguageProvider languageProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.text("language"),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        _buildLanguageTile(
          title: languageProvider.text("english"),
          languageCode: "en",
          provider: languageProvider,
        ),

        _buildLanguageTile(
          title: languageProvider.text("arabic"),
          languageCode: "ar",
          provider: languageProvider,
        ),
      ],
    );
  }

  /// Language Radio Tile
  Widget _buildLanguageTile({
    required String title,
    required String languageCode,
    required LanguageProvider provider,
  }) {
    return RadioListTile<String>(
      title: Text(title),
      value: languageCode,
      groupValue: provider.currentLang,
      onChanged: (value) {
        if (value != null) {
          provider.changelang(value);
        }
      },
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