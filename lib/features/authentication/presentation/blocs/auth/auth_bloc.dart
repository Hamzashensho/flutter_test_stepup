// lib/features/authentication/presentation/bloc/auth/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthCheckStatus>(_onAuthCheckStatus);
  }

  void _onAuthLoginRequested(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) {
    // Store token locally (using shared_preferences or secure_storage)
    // In real app, you would persist the token
    emit(AuthAuthenticated(
      auth: event.auth,
      loginInfo: event.loginInfo,
    ));
  }

  void _onAuthLogoutRequested(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) {
    // Clear stored token
    emit(AuthUnauthenticated());
  }

  void _onAuthCheckStatus(
      AuthCheckStatus event,
      Emitter<AuthState> emit,
      ) async {
    // Check if token exists in storage
    // For now, we'll just emit unauthenticated
    // In real app, you would check token validity
    emit(AuthUnauthenticated());
  }
}