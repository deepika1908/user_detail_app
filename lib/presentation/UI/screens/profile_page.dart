import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../../../providers/language_provider.dart';
import '../../../localization/app_string.dart';
import '../../../core/styles/app_button_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/styles/text_styles.dart';

class ProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String dob;

  const ProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.dob,
  });

  Widget profileRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: AppTextStyles.smallText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? "-" : value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = AppContext(context).language;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProfileAvatar(),

              const SizedBox(height: 15),

              _buildUserName(),

              const SizedBox(height: 25),

              _buildProfileDetails(language),

              const SizedBox(height: 35),

              _buildLogoutButton(context, language),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45));
  }

  Widget _buildUserName() {
    return Text(
      "$firstName $lastName",
      style: AppTextStyles.largeText.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProfileDetails(LanguageProvider languageProvider) {
    return Column(
      children: [
        profileRow(languageProvider.text(AppStringKeys.firstName), firstName),

        profileRow(languageProvider.text(AppStringKeys.lastName), lastName),

        profileRow(languageProvider.text(AppStringKeys.phone), phone),

        profileRow(languageProvider.text(AppStringKeys.email), email),

        profileRow(languageProvider.text(AppStringKeys.dateOfBirth), dob),
      ],
    );
  }

  Widget _buildLogoutButton(
    BuildContext context,
    LanguageProvider languageProvider,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton.icon(
        style: AppButtonStyle.destructive,
        icon: const Icon(Icons.logout),
        label: Text(languageProvider.text(AppStringKeys.logout)),
        onPressed: () {
          context.go(AppRoutes.login);
        },
      ),
    );
  }
}
