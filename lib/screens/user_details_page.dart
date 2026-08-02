import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/user.dart';
import '../providers/language_provider.dart';
import '../core/extensions/context_extension.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final language = context.language;

    return Scaffold(
      appBar: _buildAppBar(language),
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

  //AppBar
  AppBar _buildAppBar(LanguageProvider languageProvider) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      title: Text(
        languageProvider.text("user_details"),
      ),
    );
  }

  //Avatar 
  Widget _buildProfileAvatar() {
    return CircleAvatar(
      radius: 50,
      backgroundColor:AppColors.white,
      child: Text(
        user.name[0],
        style: const TextStyle(
          fontSize: 36,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //User Name
  Widget _buildUserName() {
    return Text(
      user.name,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //User Details
  Widget _buildUserDetails(LanguageProvider languageProvider) {
    return Column(
      children: [
        _buildDetailTile(
          Icons.person,
          languageProvider.text("name"),
          user.name,
        ),

        _buildDetailTile(
          Icons.email,
          languageProvider.text("email"),
          user.email,
        ),

        _buildDetailTile(
          Icons.phone,
          languageProvider.text("phone"),
          user.phone,
        ),

        _buildDetailTile(
          Icons.school,
          languageProvider.text("education"),
          user.education,
        ),

        _buildDetailTile(
          Icons.people,
          languageProvider.text("gender"),
          user.gender,
        ),

        _buildDetailTile(
          Icons.cake,
          languageProvider.text("date_of_birth"),
          _getDateOfBirth(),
        ),
      ],
    );
  }

  String _getDateOfBirth() {
    final dynamic userData = user;
    final value = userData.dob;
    return value?.toString() ?? '';
  }

  //Detail Tile
  Widget _buildDetailTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}