sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class LoginSubmitted extends AuthenticationEvent {
  const LoginSubmitted({required this.email, required this.password});
  final String email;
  final String password;
}

final class RegistrationSubmitted extends AuthenticationEvent {
  const RegistrationSubmitted({required this.firstName, required this.lastName, required this.phone, required this.email, required this.dob});
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String dob;
}

final class OtpSubmitted extends AuthenticationEvent {
  const OtpSubmitted(this.otp);
  final String otp;
}
