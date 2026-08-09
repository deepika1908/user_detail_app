import 'package:flutter/material.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/theme/app_colors.dart';

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
    title: Text(title, style: ScreenTextStyles.appBarTitle),
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
