import 'package:flutter/material.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../models/user.dart';
import '../../../providers/language_provider.dart';
import '../../../localization/app_string.dart';
import '../../../core/extensions/context_extension.dart';
import '../widgets/common_app_bar.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final language = AppContext(context).language;

    return Scaffold(
      appBar: buildAppBar(title: language.text(AppStringKeys.userDetails)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileAvatar(),

            const SizedBox(height: 15),

            _buildUserName(),

            const SizedBox(height: 30),

            _buildUserDetails(language),
          ],
        ),
      ),
    );
  }

  //Avatar
  Widget _buildProfileAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.white,
      child: Text(
        user.firstName[0],
        style: AppTextStyles.extraLargeText.copyWith(
          fontSize: 36,
          color: AppColors.primary,
        ),
      ),
    );
  }

  //User Name
  Widget _buildUserName() {
    return Text(
      '${user.firstName} ${user.lastName}',
      style: AppTextStyles.extraLargeText.copyWith(
        fontSize: 26,
        color: AppColors.textPrimary,
      ),
    );
  }

  //User Details
  Widget _buildUserDetails(LanguageProvider languageProvider) {
    return Column(
      children: [
        _buildDetailTile(
          Icons.person,
          languageProvider.text(AppStringKeys.firstName),
          user.firstName,
        ),

        _buildDetailTile(
          Icons.person,
          languageProvider.text(AppStringKeys.lastName),
          user.lastName,
        ),

        _buildDetailTile(
          Icons.email,
          languageProvider.text(AppStringKeys.email),
          user.email,
        ),

        _buildDetailTile(
          Icons.phone,
          languageProvider.text(AppStringKeys.phone),
          user.phone,
        ),
      ],
    );
  }

  //Detail Tile
  Widget _buildDetailTile(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(
          value,
          style: AppTextStyles.smallText.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
