import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'register_page.dart';
import 'otp_verification_page.dart';
import '../core/theme/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/theme/app_text_styles.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  final languageProvider = Provider.of<LanguageProvider>(context);

  return Scaffold(
    backgroundColor: AppColors.cardBackground,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p24,
          vertical: AppSizes.space30,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.space30),

              _buildLogo(),

              const SizedBox(height: AppSizes.space30),

              _buildTitle(languageProvider),

              const SizedBox(height: AppSizes.space8),

              _buildSubtitle(languageProvider),

              const SizedBox(height: AppSizes.space35),

              _buildFirstNameField(languageProvider),

              const SizedBox(height: AppSizes.space20),

              _buildLastNameField(languageProvider),

              const SizedBox(height: AppSizes.space20),

              _buildEmailField(languageProvider),

              const SizedBox(height: AppSizes.space35),

              _buildLoginButton(
                context,
                languageProvider,
              ),

              const SizedBox(height: AppSizes.space20),

              _buildRegisterSection(
                context,
                languageProvider,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}}

Widget _buildLogo() {
  return const Center(
    child: Icon(
      Icons.lock_outline,
      size: AppSizes.logoSize,
      color: AppColors.primary,
    ),
  );
}

Widget _buildTitle(LanguageProvider languageProvider) {
  return Center(
    child: Text(
      languageProvider.text("welcome_back"),
      style: AppTextStyles.heading,
    ),
  );
}

Widget _buildSubtitle(LanguageProvider languageProvider) {
  return Center(
    child: Text(
      languageProvider.text("login_to_continue"),
      style: AppTextStyles.body.copyWith(
      color: AppColors.textSecondary,
),
    ),
  );
}

InputDecoration _inputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

Widget _buildFirstNameField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("first_name"),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: AppSizes.space8),

      TextFormField(
        controller: firstNameController,
        decoration: _inputDecoration(
          languageProvider.text("enter_first_name"),
          Icons.person,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return languageProvider.text(
              "first_name_required",
            );
          }
          return null;
        },
      ),
    ],
  );
}

Widget _buildLastNameField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("last_name"),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: AppSizes.space8),

      TextFormField(
        controller: lastNameController,
        decoration: _inputDecoration(
          languageProvider.text("enter_last_name"),
          Icons.person,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return languageProvider.text(
              "last_name_required",
            );
          }
          return null;
        },
      ),
    ],
  );
}
Widget _buildEmailField(
  LanguageProvider languageProvider,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text("email"),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: AppSizes.space8),

      TextFormField(
        controller: emailController,
        decoration: _inputDecoration( 
          languageProvider.text("enter_email"),
          Icons.email_outlined,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return languageProvider.text(
              "email_required",
            );
          }
          return null;
        },
      ),
    ],
  );
}

Widget _buildLoginButton(
  BuildContext context,
  LanguageProvider languageProvider,
) {
  return SizedBox(
    width: double.infinity,
    height: AppSizes.buttonHeight,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius12,),
        ),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpVerificationPage(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                phone: "",
                dob: "",
              ),
            ),
          );
        }
      },
      child: Text(
        languageProvider.text("login"),
        style: AppTextStyles.button,
      ),
    ),
  );
}

Widget _buildRegisterSection(
  BuildContext context,
  LanguageProvider languageProvider,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        languageProvider.text("new_user"),
        style: AppTextStyles.body,
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RegisterPage(),
            ),
          );
        },
        child: Text(
          languageProvider.text("register"),
        ),
      ),
    ],
  );
}