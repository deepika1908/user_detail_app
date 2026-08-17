import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../presentation/UI/screens/dashboard_page.dart';
import '../../presentation/UI/screens/login_page.dart';
import '../../presentation/UI/screens/otp_verification_page.dart';
import '../../presentation/UI/screens/register_page.dart';
import '../../presentation/UI/screens/user_details_page.dart';

class AppRoutes {
  AppRoutes._();

  static const login = '/';
  static const register = '/register';
  static const otpVerification = '/otp-verification';
  static const dashboard = '/dashboard';
  static const userDetails = '/user-details';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      login => const LoginPage(),
      register => const RegisterPage(),
      otpVerification => _otpPage(_argumentsOf<OtpRouteArguments>(settings)),
      dashboard => _dashboardPage(_argumentsOf<DashboardRouteArguments>(settings)),
      userDetails => UserDetailsPage(user: _argumentsOf<UserDetailsRouteArguments>(settings).user),
      _ => const LoginPage(),
    };

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => page,
    );
  }

  static OtpVerificationPage _otpPage(OtpRouteArguments arguments) {
    return OtpVerificationPage(
      firstName: arguments.firstName,
      lastName: arguments.lastName,
      phone: arguments.phone,
      email: arguments.email,
      dob: arguments.dob,
    );
  }

  static DashboardPage _dashboardPage(DashboardRouteArguments arguments) {
    return DashboardPage(
      firstName: arguments.firstName,
      lastName: arguments.lastName,
      phone: arguments.phone,
      email: arguments.email,
      dob: arguments.dob,
    );
  }

  static T _argumentsOf<T>(RouteSettings settings) {
    final arguments = settings.arguments;
    if (arguments is T) return arguments;
    throw ArgumentError('Route "${settings.name}" requires $T arguments.');
  }
}

class OtpRouteArguments {
  const OtpRouteArguments({
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.dob,
  });

  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? dob;
}

class DashboardRouteArguments {
  const DashboardRouteArguments({
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

class UserDetailsRouteArguments {
  const UserDetailsRouteArguments(this.user);

  final User user;
}
