import 'package:flutter/material.dart';

class CustomProfileTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const CustomProfileTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}