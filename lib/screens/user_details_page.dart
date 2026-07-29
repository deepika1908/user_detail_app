import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/language_provider.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({
    super.key,
    required this.user,
  });

  Widget detailTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepPurple,
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

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          languageProvider.text("user_details"),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                user.name[0],
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              user.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            detailTile(
              Icons.person,
              languageProvider.text("name"),
              user.name,
            ),

            detailTile(
              Icons.email,
              languageProvider.text("email"),
              user.email,
            ),

            detailTile(
              Icons.phone,
              languageProvider.text("phone"),
              user.phone,
            ),

            detailTile(
              Icons.school,
              languageProvider.text("education"),
              user.education,
            ),

            detailTile(
              Icons.people,
              languageProvider.text("gender"),
              user.gender,
            ),
          ],
        ),
      ),
    );
  }
}