import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../providers/language_provider.dart';
import '../../../core/routes/app_routes.dart';
import '../../../localization/app_string.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_input_decorator.dart';
import '../../../core/theme/app_button_style.dart';
import '../../../core/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateFields() {
     final language = AppContext(context).language;

    if (_emailController.text.trim().isEmpty) {
      _showSnackBar(
        language.text("email_required"),
      );
      return false;
    }

    if (!_emailController.text.contains("@")) {
      _showSnackBar(
        language.text("invalid_email"),
      );
      return false;
    }

    if (_passwordController.text.trim().isEmpty) {
    _showSnackBar(
      language.text("password_required"),
    );
    return false;
  }

  if (_passwordController.text.length < 6) {
    _showSnackBar(
      language.text("password_length"),
    );
    return false;
  }

    return true;
  }


void _showSnackBar(String message) {
  ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();

  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p24,
            vertical: AppSizes.space30,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSizes.space30,
              ),

              _buildLogo(),

              const SizedBox(
                height: AppSizes.space30,
              ),

              _buildTitle(languageProvider),

              const SizedBox(
                height: AppSizes.space8,
              ),

              _buildSubtitle(languageProvider),

              const SizedBox(
                height: AppSizes.space35,
              ),

              const SizedBox(
                height: AppSizes.space20,
              ),

              const SizedBox(
                height: AppSizes.space20,
              ),

              _buildEmailField(languageProvider),

              const SizedBox(
                height: AppSizes.space35,
              ),

              _buildPasswordField(languageProvider),

              const SizedBox(
                height: AppSizes.space35,
              ),

              _buildLoginButton(languageProvider),

              const SizedBox(
                height: AppSizes.space20,
              ),

              _buildRegisterSection(languageProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Center(
      child: Icon(
        Icons.lock_outline,
        size: AppSizes.logoSize,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTitle(dynamic languageProvider) {
    return Center(
      child: Text(
        languageProvider.text("welcome_back"),
        style: AppTextStyles.heading,
      ),
    );
  }

  Widget _buildSubtitle(dynamic languageProvider) {
    return Center(
      child: Text(
        languageProvider.text("login_to_continue"),
        style: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }


  Widget _buildEmailField(dynamic languageProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.text(AppStringKeys.email),
        ),

        const SizedBox(
          height: AppSizes.space8,
        ),

        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: AppInputDecoration.textField(
            hintText: languageProvider.text(
              "enter_email",
            ),
            icon: Icons.email_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(dynamic languageProvider) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        languageProvider.text(AppStringKeys.password),
      ),

      const SizedBox(
        height: AppSizes.space8,
      ),

      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: AppInputDecoration.textField(
          hintText: languageProvider.text(AppStringKeys.enterPassword),
          icon: Icons.lock_outline,
        ),
      ),
    ],
  );
}
  Widget _buildLoginButton(dynamic languageProvider) {
  return SizedBox(
    width: double.infinity,
    height: AppSizes.buttonHeight,
    child: ElevatedButton(
      style: AppButtonStyle.primary,
      onPressed: () {
        if (!_validateFields()) return;

        final isValidUser = AuthService.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!isValidUser) {
          _showSnackBar(
            AppContext(context).language.text("invalid_credentials"),
          );
          return;
        }

        Navigator.pushNamed(
          context,
          AppRoutes.otpVerification,
          arguments: OtpRouteArguments(email: _emailController.text.trim()),
        );
      },
      child: Text(
        languageProvider.text(AppStringKeys.login),
        style: AppTextStyles.button,
      ),
    ),
  );
}

  Widget _buildRegisterSection(dynamic languageProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          languageProvider.text("new_user"),
          style: AppTextStyles.body,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.register);
          },
          
          child: Text(
            languageProvider.text(AppStringKeys.register),
          ),
        ),
      ],
    );
  }
}
