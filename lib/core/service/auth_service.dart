import '/data/dummy_login_users.dart';

class AuthService {
  AuthService._();

  static bool login({
    required String email,
    required String password,
  }) {
    return DummyUsers.users.any(
      (user) =>
          user["email"] == email &&
          user["password"] == password,
    );
  }
}