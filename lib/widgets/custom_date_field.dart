import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? Function(String?)? validator;

  const CustomDateField({
    super.key,
    required this.controller,
    required this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: validator,
      onTap: onTap,
      decoration: const InputDecoration(
        hintText: "Date of Birth",
        prefixIcon: Icon(Icons.calendar_today),
      ),
    );
  }
}