import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/app/app_bloc.dart';
import '../bloc/app/app_event.dart';
import '../bloc/app/app_state.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/constants/app_icons.dart';
import '../../../localization/app_string.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Unified state BLoC: supplies settings and receives settings changes.
    final settings = context.watch<AppBloc>().state;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
      actions: [_buildCloseButton(context, settings)],
    );
  }

  /// Header
  Widget _buildHeader(AppState languageProvider) {
    return Row(
      children: [
        const Icon(AppIcons.settings),
        const SizedBox(width: 10),
        Text(
          languageProvider.text(AppStringKeys.settings),
          style: AppTextStyles.smallText.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// Theme Section
  Widget _buildThemeSection(BuildContext context, AppState languageProvider) {
    return RadioGroup<bool>(
      groupValue: languageProvider.isDarkMode,
      onChanged: (value) {
        if (value != null) {
          // Unified state BLoC: persists the selected theme mode.
          context.read<AppBloc>().add(
            AppThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.text(AppStringKeys.theme),
            style: AppTextStyles.mediumText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildThemeTile(
            title: languageProvider.text(AppStringKeys.light),
            value: false,
          ),
          _buildThemeTile(
            title: languageProvider.text(AppStringKeys.dark),
            value: true,
          ),
        ],
      ),
    );
  }

  /// Theme Radio Tile
  Widget _buildThemeTile({required String title, required bool value}) {
    return RadioListTile<bool>(title: Text(title), value: value);
  }

  /// Language Section
  Widget _buildLanguageSection(
    BuildContext context,
    AppState languageProvider,
  ) {
    return RadioGroup<String>(
      groupValue: languageProvider.languageCode,
      onChanged: (value) {
        if (value != null) {
          // Unified state BLoC: persists the selected language.
          context.read<AppBloc>().add(AppLanguageChanged(value));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languageProvider.text(AppStringKeys.language),
            style: AppTextStyles.mediumText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildLanguageTile(
            title: languageProvider.text(AppStringKeys.english),
            languageCode: "en",
          ),
          _buildLanguageTile(
            title: languageProvider.text(AppStringKeys.arabic),
            languageCode: "ar",
          ),
        ],
      ),
    );
  }

  /// Language Radio Tile
  Widget _buildLanguageTile({
    required String title,
    required String languageCode,
  }) {
    return RadioListTile<String>(title: Text(title), value: languageCode);
  }

  /// Close Button
  Widget _buildCloseButton(BuildContext context, AppState languageProvider) {
    return TextButton(
      onPressed: () {
        context.pop();
      },
      child: Text(languageProvider.text(AppStringKeys.close)),
    );
  }
}
