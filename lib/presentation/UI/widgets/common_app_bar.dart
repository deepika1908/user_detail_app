import 'package:flutter/material.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/styles/app_colors.dart';

PreferredSizeWidget buildAppBar({
  required String title,
  VoidCallback? onActionPressed,
  IconData? actionIcon,
  bool automaticallyImplyLeading = true,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    elevation: 0,
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    centerTitle: true,
    title: Text(
      title,
      style: AppTextStyles.smallText.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
    actions: onActionPressed == null
        ? null
        : [
            IconButton(
              icon: Icon(actionIcon ?? AppIcons.settings),
              onPressed: onActionPressed,
            ),
          ],
  );
}
