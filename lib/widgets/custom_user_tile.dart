import 'package:flutter/material.dart';

class CustomUserTile extends StatelessWidget {
  final Map<String, String> student;
  final VoidCallback onTap;

  const CustomUserTile({
    super.key,
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(student["name"]![0]),
        ),
        title: Text(student["name"] ?? ""),
        subtitle: Text(student["email"] ?? ""),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}