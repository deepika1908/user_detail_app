import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_detail_app/core/extensions/context_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_button_style.dart';
import '../../../core/theme/app_input_decorator.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../localization/app_string.dart';

class OtpVerificationPage extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String email;
  final String? dob;

  const OtpVerificationPage({
    super.key,
    this.firstName,
    this.lastName,
    this.phone,
    required this.email,
    this.dob,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

 class _OtpVerificationPageState extends State<OtpVerificationPage> {
final TextEditingController otpController = TextEditingController();

// Dummy OTP
final String savedOtp = "123456";

void verifyOtp() {
  if (otpController.text.trim().isEmpty) {
    _showSnackBar("OTP is required");
    return;
  }

  if (!RegExp(r'^\d{6}$').hasMatch(otpController.text.trim())) {
    _showSnackBar("Invalid OTP");
    return;
  }

  if (otpController.text.trim() == savedOtp) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.dashboard,
      (route) => false,
      arguments: DashboardRouteArguments(
        firstName: widget.firstName ?? '',
        lastName: widget.lastName ?? '',
        phone: widget.phone ?? '',
        email: widget.email,
        dob: widget.dob ?? '',
      ),
    );
  } else {
    _showSnackBar("Invalid OTP");
  }
}

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  final languageProvider = Provider.of<LanguageProvider>(context);

  return Scaffold(
    //backgroundColor: AppColors.scaffoldBackground,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        //child: Form(
          //key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),

              _buildHeader(languageProvider),

              const SizedBox(height: 40),

              _buildOtpField(languageProvider),

              const SizedBox(height: 30),

              _buildVerifyButton(languageProvider),

              const SizedBox(height: 25),

              _buildResendButton(languageProvider),

              const SizedBox(height: 20),

              _buildDemoOtp(languageProvider),
            ],
          ),
        ),
      ),
    );
}

Widget _buildHeader(LanguageProvider languageProvider) {
  return Column(
    children: [
      const Icon(
        Icons.verified_user_outlined,
        color: AppColors.primary,
        size: 90,
      ),

      const SizedBox(height: 25),

      Text(
        languageProvider.text("otp_verification"),
        style: ScreenTextStyles.userName.copyWith(fontSize: 28),
      ),

      const SizedBox(height: 10),

      Text(
        languageProvider.text("enter_6_digit_otp"),
        textAlign: TextAlign.center,
        style: ScreenTextStyles.subtitle,
      ),
    ],
  );
}


Widget _buildOtpField(LanguageProvider languageProvider) {
  return TextField(
    controller: otpController,
    keyboardType: TextInputType.number,
    maxLength: 6,
    decoration: AppInputDecoration.textField(
      hintText: languageProvider.text("enter_otp"),
      icon: Icons.lock_outline,
      counterText: "",
    ),
  );
}

Widget _buildVerifyButton(LanguageProvider languageProvider) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      style: AppButtonStyle.primary,
      onPressed: _verifyOtp,
      child: Text(
        languageProvider.text("verify_otp"),
        style: ScreenTextStyles.welcomeSubtitle.copyWith(fontSize: 18),
      ),
    ),
  );
}

Widget _buildResendButton(LanguageProvider languageProvider) {
  return TextButton(
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            languageProvider.text("otp_resent_successfully"),
          ),
        ),
      );
    },
    child: Text(
      languageProvider.text("resend_otp"),
      style: ScreenTextStyles.body,
    ),
  );
}

Widget _buildDemoOtp(LanguageProvider languageProvider) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      languageProvider.text("demo_otp"),
      style: ScreenTextStyles.detailLabel.copyWith(color: AppColors.scaffoldBackground),
    ),
  );
}

void _verifyOtp() {
  final language = AppContext(context).language;

  if (otpController.text.trim().isEmpty) {
    _showSnackBar(
      language.text(AppStringKeys.otpRequired),
    );
    return;
  }

  if (!RegExp(r'^\d{6}$').hasMatch(otpController.text.trim())) {
    _showSnackBar(
      language.text(AppStringKeys.invalidOtp),
    );
    return;
  }

  if (otpController.text.trim() != savedOtp) {
    _showSnackBar(
      language.text(AppStringKeys.invalidOtp),
    );
    return;
  }

  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.dashboard,
    (route) => false,
    arguments: DashboardRouteArguments(
      firstName: widget.firstName ?? '',
      lastName: widget.lastName ?? '',
      phone: widget.phone ?? '',
      email: widget.email,
      dob: widget.dob ?? '',
    ),
  );
}

void _showSnackBar(String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

// void _showInvalidOtp() {
//   final languageProvider =
//       Provider.of<LanguageProvider>(context, listen: false);

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: Colors.red,
//       content: Text(
//         languageProvider.text("invalid_otp"),
//       ),
//     ),
//   );
// }

}
