import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/styles/app_button_style.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_input_decorator.dart';
import '../../../core/styles/text_styles.dart';
import '../../../localization/app_string.dart';
import '../../../providers/language_provider.dart';
import '../bloc/app/app_bloc.dart';
import '../bloc/app/app_event.dart';
import '../bloc/app/app_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _dob = TextEditingController();

  @override
  void dispose() {
    for (final controller in [_firstName, _lastName, _phone, _email, _dob]) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      _dob.text = '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Unified state BLoC: handles registration feedback and route transitions.
      BlocListener<AppBloc, AppState>(
        listenWhen: (previous, current) =>
            current.authenticationFlow == AuthenticationFlow.registration &&
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
            context.push(
              AppRoutes.otpVerification,
              extra: OtpRouteArguments(
                firstName: _firstName.text.trim(),
                lastName: _lastName.text.trim(),
                phone: _phone.text.trim(),
                email: _email.text.trim(),
                dob: _dob.text.trim(),
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
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    const Center(
                      child: Icon(
                        Icons.person_add_alt_1,
                        size: 90,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: Text(
                        language.text(AppStringKeys.createAccount),
                        style: AppTextStyles.extraLargeText.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Center(
                      child: Text(language.text(AppStringKeys.fillDetails)),
                    ),

                    const SizedBox(height: 35),

                    _field(
                      language,
                      AppStringKeys.firstName,
                      AppStringKeys.enterFirstName,
                      _firstName,
                      Icons.person,
                    ),

                    const SizedBox(height: 20),

                    _field(
                      language,
                      AppStringKeys.lastName,
                      AppStringKeys.enterLastName,
                      _lastName,
                      Icons.person_outline,
                    ),

                    const SizedBox(height: 20),

                    _field(
                      language,
                      AppStringKeys.phoneNumber,
                      AppStringKeys.enterPhoneNumber,
                      _phone,
                      Icons.phone,
                      type: TextInputType.phone,
                    ),

                    const SizedBox(height: 20),

                    _field(
                      language,
                      AppStringKeys.email,
                      AppStringKeys.enterEmail,
                      _email,
                      Icons.email,
                      type: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 20),

                    Text(language.text(AppStringKeys.dateOfBirth)),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _dob,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: AppInputDecoration.textField(
                        hintText: language.text(AppStringKeys.enterDateOfBirth),
                        icon: Icons.calendar_today,
                      ),
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: AppButtonStyle.primary,
                        onPressed: () {
                          // Unified state BLoC: validates registration details.
                          context.read<AppBloc>().add(
                            AppRegistrationSubmitted(
                              firstName: _firstName.text,
                              lastName: _lastName.text,
                              phone: _phone.text,
                              email: _email.text,
                              dob: _dob.text,
                            ),
                          );
                        },
                        child: Text(
                          language.text(AppStringKeys.register),
                          style: AppTextStyles.smallText.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(language.text(AppStringKeys.alreadyHaveAccount)),
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(language.text(AppStringKeys.login)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _field(
    LanguageProvider language,
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    TextInputType? type,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(language.text(label)),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        keyboardType: type,
        decoration: AppInputDecoration.textField(
          hintText: language.text(hint),
          icon: icon,
        ),
      ),
    ],
  );

  void _message(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
