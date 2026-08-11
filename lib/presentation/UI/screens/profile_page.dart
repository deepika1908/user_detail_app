import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../providers/language_provider.dart';
import '../../../core/theme/app_button_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/styles/screen_text_styles.dart';


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
              style: ScreenTextStyles.detailLabel,
            ),
          ),
          Expanded(
            child: Text(value.isEmpty ? "-" : value),
          ),
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
  return const CircleAvatar(
    radius: 45,
    child: Icon(
      Icons.person,
      size: 45,
    ),
  );
}Widget _buildUserName() {
  return Text(
    "$firstName $lastName",
    style: ScreenTextStyles.profileName,
  );
}

Widget _buildProfileDetails(LanguageProvider languageProvider) {
  return Column(
    children: [
      profileRow(
        languageProvider.text("first_name"),
        firstName,
      ),

      profileRow(
        languageProvider.text("last_name"),
        lastName,
      ),

      profileRow(
        languageProvider.text("phone"),
        phone,
      ),

      profileRow(
        languageProvider.text("email"),
        email,
      ),

      profileRow(
        languageProvider.text("date_of_birth"),
        dob,
      ),
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
      label: Text(
        languageProvider.text("logout"),
      ),
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      },
    ),
  );
}

}
