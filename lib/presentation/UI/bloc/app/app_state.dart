import 'package:flutter/material.dart';

import '../../../../localization/app_string.dart';
import '../../../../models/user.dart';

enum AuthenticationStatus { initial, success, failure }

enum AuthenticationFlow { none, login, registration, otp }

enum UsersStatus { initial, loading, success, failure }

class AppState {
  const AppState({
    this.themeMode = ThemeMode.light,
    this.languageCode = 'en',
    this.authenticationStatus = AuthenticationStatus.initial,
    this.authenticationFlow = AuthenticationFlow.none,
    this.authenticationErrorKey,
    this.selectedDashboardIndex = 0,
    this.usersStatus = UsersStatus.initial,
    this.users = const [],
    this.userSearchText = '',
    this.usersErrorMessage,
  });

  final ThemeMode themeMode;
  final String languageCode;
  final AuthenticationStatus authenticationStatus;
  final AuthenticationFlow authenticationFlow;
  final String? authenticationErrorKey;
  final int selectedDashboardIndex;
  final UsersStatus usersStatus;
  final List<User> users;
  final String userSearchText;
  final String? usersErrorMessage;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  String text(String key) => AppStringKeys.value[languageCode]?[key] ?? key;

  List<User> get filteredUsers {
    final query = userSearchText.trim().toLowerCase();
    if (query.isEmpty) return users;

    return users
        .where(
          (user) => '${user.firstName} ${user.lastName}'.toLowerCase().contains(
            query,
          ),
        )
        .toList();
  }

  AppState copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    AuthenticationStatus? authenticationStatus,
    AuthenticationFlow? authenticationFlow,
    String? authenticationErrorKey,
    bool clearAuthenticationError = false,
    int? selectedDashboardIndex,
    UsersStatus? usersStatus,
    List<User>? users,
    String? userSearchText,
    String? usersErrorMessage,
    bool clearUsersError = false,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      authenticationFlow: authenticationFlow ?? this.authenticationFlow,
      authenticationErrorKey: clearAuthenticationError
          ? null
          : authenticationErrorKey ?? this.authenticationErrorKey,
      selectedDashboardIndex:
          selectedDashboardIndex ?? this.selectedDashboardIndex,
      usersStatus: usersStatus ?? this.usersStatus,
      users: users ?? this.users,
      userSearchText: userSearchText ?? this.userSearchText,
      usersErrorMessage: clearUsersError
          ? null
          : usersErrorMessage ?? this.usersErrorMessage,
    );
  }
}
