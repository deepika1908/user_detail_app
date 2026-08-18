import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routes.dart';
import '../../../localization/app_string.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/theme/app_button_style.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_input_decorator.dart';
import '../bloc/authentication/authentication_bloc.dart';
import '../bloc/authentication/authentication_event.dart';
import '../bloc/authentication/authentication_state.dart';
import '../bloc/settings/settings_bloc.dart';
import '../bloc/settings/settings_state.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    this.firstName,
    this.lastName,
    this.phone,
    required this.email,
    this.dob,
  });

  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dob;
  final String email;

  @override
  State<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AuthenticationBloc(),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.failure) {
              _message(
                context
                    .read<SettingsBloc>()
                    .state
                    .text(state.errorKey!),
              );
            }

            if (state.status == AuthenticationStatus.success) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.dashboard,
                (_) => false,
                arguments: DashboardRouteArguments(
                  firstName: widget.firstName ?? '',
                  lastName: widget.lastName ?? '',
                  phone: widget.phone ?? '',
                  email: widget.email,
                  dob: widget.dob ?? '',
                ),
              );
            }
          },
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, language) => Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      const Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.primary,
                        size: 90,
                      ),

                      const SizedBox(height: 25),

                      Text(
                        language.text(
                          AppStringKeys.otpVerification,
                        ),
                        style: ScreenTextStyles.userName.copyWith(
                          fontSize: 28,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        language.text(
                          AppStringKeys.enterSixDigitOtp,
                        ),
                        textAlign: TextAlign.center,
                        style: ScreenTextStyles.subtitle,
                      ),

                      const SizedBox(height: 40),

                      TextField(
                        controller: _otp,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: AppInputDecoration.textField(
                          hintText: language.text(
                            AppStringKeys.enterOtp,
                          ),
                          icon: Icons.lock_outline,
                          counterText: '',
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: AppButtonStyle.primary,
                          onPressed: () {
                            context.read<AuthenticationBloc>().add(
                                  OtpSubmitted(_otp.text),
                                );
                          },
                          child: Text(
                            language.text(
                              AppStringKeys.verifyOtp,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextButton(
                        onPressed: () {
                          _message(
                            language.text(
                              AppStringKeys.otpResentSuccessfully,
                            ),
                          );
                        },
                        child: Text(
                          language.text(
                            AppStringKeys.resendOtp,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          language.text(
                            AppStringKeys.demoOtp,
                          ),
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void _message(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
      ),
    );
  }
}