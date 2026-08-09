import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ScreenTextStyles {
  ScreenTextStyles._();

  static const appBarTitle = TextStyle(fontWeight: FontWeight.bold);
  static const sectionTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const subtitle = TextStyle(color: AppColors.grey, fontSize: 16);
  static const body = TextStyle(fontSize: 16);
  static const userInitial = TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold);
  static const userName = TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
  static const profileName = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static const detailLabel = TextStyle(fontWeight: FontWeight.bold);
  static const detailValue = TextStyle(fontWeight: FontWeight.w600);
  static const welcomeTitle = TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.bold);
  static const welcomeSubtitle = TextStyle(color: AppColors.white);
}
