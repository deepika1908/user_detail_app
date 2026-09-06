import 'package:flutter/material.dart';

class AppInputDecoration {
  AppInputDecoration._();

  static InputDecoration textField({
    required String hintText,
    required IconData icon,
    String? counterText,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      counterText: counterText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
