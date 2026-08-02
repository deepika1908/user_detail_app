// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final bool isLoading;
//   final IconData? icon;

//   const CustomButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.isLoading = false,
//     this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         child: isLoading
//             ? const CircularProgressIndicator(
//                 color: Colors.white,
//               )
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (icon != null) ...[
//                     Icon(icon),
//                     const SizedBox(width: 8),
//                   ],
//                   Text(text),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class AppButtonStyle {

  AppButtonStyle._();

  static ButtonStyle primary = ElevatedButton.styleFrom(

    backgroundColor: AppColors.primary,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),

  );

}