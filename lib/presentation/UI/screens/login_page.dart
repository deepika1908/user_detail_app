import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_button_style.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_input_decorator.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../localization/app_string.dart';
import '../../../providers/language_provider.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_event.dart';
import '../bloc/authentication/authentication_state.dart';
import '../bloc/settings/settings_bloc.dart';
import '../bloc/settings/settings_state.dart';

class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState() => _LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => AuthenticationBloc(),
    child: BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.failure) _message(context.read<SettingsBloc>().state.text(state.errorKey!));
        if (state.status == AuthenticationStatus.success) Navigator.pushNamed(context, AppRoutes.otpVerification, arguments: OtpRouteArguments(email: _email.text.trim()));
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, language) => Scaffold(body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24, vertical: AppSizes.space30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: AppSizes.space30), const Center(child: Icon(Icons.lock_outline, size: AppSizes.logoSize, color: AppColors.primary)),
          const SizedBox(height: AppSizes.space30), Center(child: Text(language.text(AppStringKeys.welcomeBack), style: AppTextStyles.heading)),
          const SizedBox(height: AppSizes.space8), Center(child: Text(language.text(AppStringKeys.loginToContinue), style: AppTextStyles.body.copyWith(color: AppColors.textSecondary))),
          const SizedBox(height: AppSizes.space35), _field(language.text(AppStringKeys.email), language.text(AppStringKeys.enterEmail), _email, Icons.email_outlined, TextInputType.emailAddress),
          const SizedBox(height: AppSizes.space20), _field(language.text(AppStringKeys.password), language.text(AppStringKeys.enterPassword), _password, Icons.lock_outline, null, obscure: true),
          const SizedBox(height: AppSizes.space35), SizedBox(width: double.infinity, height: AppSizes.buttonHeight, child: ElevatedButton(style: AppButtonStyle.primary, onPressed: () => context.read<AuthenticationBloc>().add(LoginSubmitted(email: _email.text, password: _password.text)), child: Text(language.text(AppStringKeys.login), style: AppTextStyles.button))),
          const SizedBox(height: AppSizes.space20), Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(language.text(AppStringKeys.newUser)), TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.register), child: Text(language.text(AppStringKeys.register)))])
        ]),
      )))),
    ),
  );

  Widget _field(String label, String hint, TextEditingController controller, IconData icon, TextInputType? type, {bool obscure = false}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label), const SizedBox(height: 8), TextField(controller: controller, obscureText: obscure, keyboardType: type, decoration: AppInputDecoration.textField(hintText: hint, icon: icon))]);
  void _message(String value) { ScaffoldMessenger.of(context).hideCurrentSnackBar(); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value))); }
}
