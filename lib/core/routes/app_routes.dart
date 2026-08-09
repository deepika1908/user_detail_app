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

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case otpVerification:
        final arguments = settings.arguments! as OtpRouteArguments;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationPage(
            firstName: arguments.firstName,
            lastName: arguments.lastName,
            phone: arguments.phone,
            email: arguments.email,
            dob: arguments.dob,
          ),
        );
      case dashboard:
        final arguments = settings.arguments! as DashboardRouteArguments;
        return MaterialPageRoute(
          builder: (_) => DashboardPage(
            firstName: arguments.firstName,
            lastName: arguments.lastName,
            phone: arguments.phone,
            email: arguments.email,
            dob: arguments.dob,
          ),
        );
      case userDetails:
        final arguments = settings.arguments! as UserDetailsRouteArguments;
        return MaterialPageRoute(
          builder: (_) => UserDetailsPage(user: arguments.user),
        );
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
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
