import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../localization/app_string.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/styles/app_button_style.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_input_decorator.dart';
import '../bloc/app/app_bloc.dart';
import '../bloc/app/app_event.dart';
import '../bloc/app/app_state.dart';

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
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // Unified state BLoC: handles OTP feedback and dashboard navigation.
      BlocListener<AppBloc, AppState>(
        listenWhen: (previous, current) =>
            current.authenticationFlow == AuthenticationFlow.otp &&
            (previous.authenticationFlow != current.authenticationFlow ||
                previous.authenticationStatus != current.authenticationStatus ||
                previous.authenticationErrorKey !=
                    current.authenticationErrorKey),
        listener: (context, state) {
          if (state.authenticationStatus == AuthenticationStatus.failure) {
            _message(
              context.read<AppBloc>().state.text(state.authenticationErrorKey!),
            );
          }

          if (state.authenticationStatus == AuthenticationStatus.success) {
            context.go(
              AppRoutes.dashboard,
              extra: DashboardRouteArguments(
                firstName: widget.firstName ?? '',
                lastName: widget.lastName ?? '',
                phone: widget.phone ?? '',
                email: widget.email,
                dob: widget.dob ?? '',
              ),
            );
          }
        },
        // Unified state BLoC: supplies the active language to the screen.
        child: BlocBuilder<AppBloc, AppState>(
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
                      language.text(AppStringKeys.otpVerification),
                      style: AppTextStyles.extraLargeText.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      language.text(AppStringKeys.enterSixDigitOtp),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.smallText.copyWith(
                        color: AppColors.grey,
                      ),
                    ),

                    const SizedBox(height: 40),

                    TextField(
                      controller: _otp,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: AppInputDecoration.textField(
                        hintText: language.text(AppStringKeys.enterOtp),
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
                          // Unified state BLoC: verifies the entered OTP.
                          context.read<AppBloc>().add(
                            AppOtpSubmitted(_otp.text),
                          );
                        },
                        child: Text(language.text(AppStringKeys.verifyOtp)),
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextButton(
                      onPressed: () {
                        _message(
                          language.text(AppStringKeys.otpResentSuccessfully),
                        );
                      },
                      child: Text(language.text(AppStringKeys.resendOtp)),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        language.text(AppStringKeys.demoOtp),
                        style: AppTextStyles.smallText.copyWith(
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
      );

  void _message(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
