import 'package:flutter/material.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppThemeModeChanged extends AppEvent {
  const AppThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;
}

final class AppLanguageChanged extends AppEvent {
  const AppLanguageChanged(this.languageCode);

  final String languageCode;
}

final class AppLoginSubmitted extends AppEvent {
  const AppLoginSubmitted({required this.email, required this.password});

  final String email;
  final String password;
}

final class AppRegistrationSubmitted extends AppEvent {
  const AppRegistrationSubmitted({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.dob,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String dob;
}

final class AppOtpSubmitted extends AppEvent {
  const AppOtpSubmitted(this.otp);

  final String otp;
}

final class AppDashboardTabChanged extends AppEvent {
  const AppDashboardTabChanged(this.index);

  final int index;
}

final class AppUsersRequested extends AppEvent {
  const AppUsersRequested();
}

final class AppUserSearchChanged extends AppEvent {
  const AppUserSearchChanged(this.searchText);

  final String searchText;
}
