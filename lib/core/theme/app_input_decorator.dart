import 'package:flutter/material.dart';

class AppInputDecoration {

  AppInputDecoration._();

  static InputDecoration textField({
    required String hintText,
    required IconData icon,
  }) {

    return InputDecoration(
      hintText: hintText,

      prefixIcon: Icon(icon),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

}