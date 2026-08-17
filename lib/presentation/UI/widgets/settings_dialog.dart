import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings/settings_bloc.dart';
import '../bloc/settings/settings_event.dart';
import '../bloc/settings/settings_state.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/constants/app_icons.dart';
import '../../../localization/app_string.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsBloc>().state;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: _buildHeader(settings),
      content: SizedBox(
        width: 320,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeSection(context, settings),

              const SizedBox(height: 20),

              _buildLanguageSection(context, settings),
            ],
          ),
        ),
      ),
      actions: [
        _buildCloseButton(context, settings),
      ],
    );
  }

  /// Header
  Widget _buildHeader(SettingsState languageProvider) {
    return Row(
      children: [
        const Icon(AppIcons.settings),
        const SizedBox(width: 10),
        Text(
          languageProvider.text(AppStringKeys.settings),
          style: ScreenTextStyles.appBarTitle,
        ),
      ],
    );
  }

  /// Theme Section
  Widget _buildThemeSection(
    BuildContext context,
    SettingsState languageProvider,
  ) {
    return RadioGroup<bool>(
      groupValue: languageProvider.isDarkMode,
      onChanged: (value) {
        if (value != null) context.read<SettingsBloc>().add(ThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.text(AppStringKeys.theme),
            style: ScreenTextStyles.sectionTitle,
          ),
          const SizedBox(height: 10),
          _buildThemeTile(title: languageProvider.text(AppStringKeys.light), value: false),
          _buildThemeTile(title: languageProvider.text(AppStringKeys.dark), value: true),
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
    BuildContext context,
    SettingsState languageProvider,
  ) {
    return RadioGroup<String>(
      groupValue: languageProvider.languageCode,
      onChanged: (value) {
        if (value != null) context.read<SettingsBloc>().add(LanguageChanged(value));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.text(AppStringKeys.language),
            style: ScreenTextStyles.sectionTitle,
          ),
          const SizedBox(height: 10),
          _buildLanguageTile(title: languageProvider.text(AppStringKeys.english), languageCode: "en"),
          _buildLanguageTile(title: languageProvider.text(AppStringKeys.arabic), languageCode: "ar"),
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
    SettingsState languageProvider,
  ) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        languageProvider.text(AppStringKeys.close),
      ),
    );
  }
}
