import 'package:go_router/go_router.dart';

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

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(path: login, builder: (_, _) => const LoginPage()),
      GoRoute(path: register, builder: (_, _) => const RegisterPage()),
      GoRoute(
        path: otpVerification,
        builder: (_, state) {
          final arguments = state.extra as OtpRouteArguments;
          return OtpVerificationPage(
            firstName: arguments.firstName,
            lastName: arguments.lastName,
            phone: arguments.phone,
            email: arguments.email,
            dob: arguments.dob,
          );
        },
      ),
      GoRoute(
        path: dashboard,
        builder: (_, state) {
          final arguments = state.extra as DashboardRouteArguments;
          return DashboardPage(
            firstName: arguments.firstName,
            lastName: arguments.lastName,
            phone: arguments.phone,
            email: arguments.email,
            dob: arguments.dob,
          );
        },
      ),
      GoRoute(
        path: userDetails,
        builder: (_, state) {
          final arguments = state.extra as UserDetailsRouteArguments;
          return UserDetailsPage(user: arguments.user);
        },
      ),
    ],
  );
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
