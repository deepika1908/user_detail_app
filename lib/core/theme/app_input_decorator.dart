import 'package:flutter/material.dart';

class AppInputDecoration {
  AppInputDecoration._();

  static InputDecoration textField({
    required String hintText,
    required IconData icon,
    String? counterText,
    bool filled = false,
    Color? fillColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      counterText: counterText,
      filled: filled,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
