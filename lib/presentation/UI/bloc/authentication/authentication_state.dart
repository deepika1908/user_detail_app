enum AuthenticationStatus { initial, success, failure }

class AuthenticationState {
  const AuthenticationState({
    this.status = AuthenticationStatus.initial, 
    this.errorKey});
    
  final AuthenticationStatus status;
  final String? errorKey;
}
