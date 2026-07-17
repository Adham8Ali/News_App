import 'package:news_app/core/models/user_model.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthloginSuccess extends AuthState {
  final UserModel user;

  AuthloginSuccess({required this.user});
}

// class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
