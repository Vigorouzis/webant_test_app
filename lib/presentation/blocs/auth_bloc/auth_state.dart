abstract class AuthState {
  const AuthState();
}

class InitAuthState extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {}
