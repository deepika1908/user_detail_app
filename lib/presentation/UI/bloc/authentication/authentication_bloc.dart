import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/auth_service.dart';
import '../../../../localization/app_string.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<LoginSubmitted>(_login);
    on<RegistrationSubmitted>(_register);
    on<OtpSubmitted>(_verifyOtp);
  }

  void _login(
    LoginSubmitted event,
    Emitter<AuthenticationState> emit,
  ) {
    final error = _credentialsError(
      event.email,
      event.password,
    );

    if (error != null) {
      return emit(
        AuthenticationState(
          status: AuthenticationStatus.failure,
          errorKey: error,
        ),
      );
    }

    final isValidUser = AuthService.login(
      email: event.email.trim(),
      password: event.password.trim(),
    );

    emit(
      AuthenticationState(
        status: isValidUser
            ? AuthenticationStatus.success
            : AuthenticationStatus.failure,
        errorKey: isValidUser
            ? null
            : AppStringKeys.invalidCredentials,
      ),
    );
  }

  void _register(
    RegistrationSubmitted event,
    Emitter<AuthenticationState> emit,
  ) {
    final error = event.firstName.trim().isEmpty
        ? AppStringKeys.firstNameRequired
        : event.lastName.trim().isEmpty
            ? AppStringKeys.lastNameRequired
            : event.phone.trim().isEmpty
                ? AppStringKeys.phoneNumberRequired
                : event.phone.trim().length != 10
                    ? AppStringKeys.invalidPhoneNumber
                    : event.email.trim().isEmpty
                        ? AppStringKeys.emailRequired
                        : !event.email.contains('@')
                            ? AppStringKeys.invalidEmail
                            : event.dob.trim().isEmpty
                                ? AppStringKeys.dateOfBirthRequired
                                : null;

    emit(
      AuthenticationState(
        status: error == null
            ? AuthenticationStatus.success
            : AuthenticationStatus.failure,
        errorKey: error,
      ),
    );
  }

  void _verifyOtp(
    OtpSubmitted event,
    Emitter<AuthenticationState> emit,
  ) {
    final value = event.otp.trim();

    final error = value.isEmpty
        ? AppStringKeys.otpRequired
        : !RegExp(r'^\d{6}$').hasMatch(value) || value != '123456'
            ? AppStringKeys.invalidOtp
            : null;

    emit(
      AuthenticationState(
        status: error == null
            ? AuthenticationStatus.success
            : AuthenticationStatus.failure,
        errorKey: error,
      ),
    );
  }

  String? _credentialsError(
    String email,
    String password,
  ) {
    if (email.trim().isEmpty) {
      return AppStringKeys.emailRequired;
    }

    if (!email.contains('@')) {
      return AppStringKeys.invalidEmail;
    }

    if (password.trim().isEmpty) {
      return AppStringKeys.passwordRequired;
    }

    if (password.length < 6) {
      return AppStringKeys.passwordLength;
    }

    return null;
  }
}