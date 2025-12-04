// lib/features/authentication/presentation/bloc/auth/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final AuthEntity auth;
  final LoginInfoEntity loginInfo;

  const AuthLoginRequested({
    required this.auth,
    required this.loginInfo,
  });

  @override
  List<Object> get props => [auth, loginInfo];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}