import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/api_service.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../localization/app_string.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({ApiService? apiService})
    : _apiService = apiService ?? ApiService(),
      super(const AppState()) {
    on<AppThemeModeChanged>(_changeThemeMode);
    on<AppLanguageChanged>(_changeLanguage);
    on<AppLoginSubmitted>(_login);
    on<AppRegistrationSubmitted>(_register);
    on<AppOtpSubmitted>(_verifyOtp);
    on<AppDashboardTabChanged>(_changeDashboardTab);
    on<AppUsersRequested>(_loadUsers);
    on<AppUserSearchChanged>(_changeUserSearch);
  }

  final ApiService _apiService;

  void _changeThemeMode(AppThemeModeChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _changeLanguage(AppLanguageChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(languageCode: event.languageCode));
  }

  void _login(AppLoginSubmitted event, Emitter<AppState> emit) {
    final error = _credentialsError(event.email, event.password);
    if (error != null) {
      emit(
        state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          authenticationFlow: AuthenticationFlow.login,
          authenticationErrorKey: error,
        ),
      );
      return;
    }

    final isValidUser = AuthService.login(
      email: event.email.trim(),
      password: event.password.trim(),
    );
    emit(
      state.copyWith(
        authenticationStatus: isValidUser
            ? AuthenticationStatus.success
            : AuthenticationStatus.failure,
        authenticationFlow: AuthenticationFlow.login,
        authenticationErrorKey: isValidUser
            ? null
            : AppStringKeys.invalidCredentials,
        clearAuthenticationError: isValidUser,
      ),
    );
  }

  void _register(AppRegistrationSubmitted event, Emitter<AppState> emit) {
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
      state.copyWith(
        authenticationStatus: error == null
            ? AuthenticationStatus.success
            : AuthenticationStatus.failure,
        authenticationFlow: AuthenticationFlow.registration,
        authenticationErrorKey: error,
        clearAuthenticationError: error == null,
      ),
    );
  }

  void _verifyOtp(AppOtpSubmitted event, Emitter<AppState> emit) {
    final value = event.otp.trim();
    final error = value.isEmpty
        ? AppStringKeys.otpRequired
        : !RegExp(r'^\d{6}$').hasMatch(value) || value != '123456'
        ? AppStringKeys.invalidOtp
        : null;

    emit(
      state.copyWith(
        authenticationStatus: error == null
            ? AuthenticationStatus.success
            : AuthenticationStatus.failure,
        authenticationFlow: AuthenticationFlow.otp,
        authenticationErrorKey: error,
        clearAuthenticationError: error == null,
      ),
    );
  }

  void _changeDashboardTab(
    AppDashboardTabChanged event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(selectedDashboardIndex: event.index));
  }

  Future<void> _loadUsers(
    AppUsersRequested event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(usersStatus: UsersStatus.loading, clearUsersError: true),
    );
    try {
      final users = await _apiService.fetchUsers();
      emit(state.copyWith(usersStatus: UsersStatus.success, users: users));
    } catch (_) {
      emit(
        state.copyWith(
          usersStatus: UsersStatus.failure,
          usersErrorMessage: 'Could not load users',
        ),
      );
    }
  }

  void _changeUserSearch(AppUserSearchChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(userSearchText: event.searchText));
  }

  String? _credentialsError(String email, String password) {
    if (email.trim().isEmpty) return AppStringKeys.emailRequired;
    if (!email.contains('@')) return AppStringKeys.invalidEmail;
    if (password.trim().isEmpty) return AppStringKeys.passwordRequired;
    if (password.length < 6) return AppStringKeys.passwordLength;
    return null;
  }
}
