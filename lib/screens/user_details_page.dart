import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  final Map<String, String> student;

  const UserDetailsPage({
    super.key,
    required this.student,
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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("User Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                student["name"]![0],
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              student["name"]!,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            detailTile(
              Icons.person,
              "Name",
              student["name"]!,
            ),

            detailTile(
              Icons.email,
              "Email",
              student["email"]!,
            ),

            detailTile(
              Icons.phone,
              "Phone",
              student["phone"]!,
            ),

            detailTile(
              Icons.school,
              "Education",
              student["education"]!,
            ),

            detailTile(
              Icons.people,
              "Gender",
              student["gender"]!,
            ),
          ],
        ),
      ),
    );
  }
}