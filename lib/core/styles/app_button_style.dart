import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyle {
  AppButtonStyle._();

  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  static final ButtonStyle destructive = ElevatedButton.styleFrom(
    backgroundColor: AppColors.red,
    foregroundColor: AppColors.white,
  );
}
