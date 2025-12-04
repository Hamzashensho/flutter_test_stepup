part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class EditionsLoaded extends SignUpState {
  final List<EditionEntity> editions;

  const EditionsLoaded(this.editions);

  @override
  List<Object> get props => [editions];
}

class PasswordComplexityLoaded extends SignUpState {
  final PasswordComplexityEntity complexity;

  const PasswordComplexityLoaded(this.complexity);

  @override
  List<Object> get props => [complexity];
}

class TenantAvailabilityChecked extends SignUpState {
  final TenantAvailabilityEntity availability;

  const TenantAvailabilityChecked(this.availability);

  @override
  List<Object> get props => [availability];
}

class TenantRegistered extends SignUpState {
  final AuthEntity auth;

  const TenantRegistered(this.auth);

  @override
  List<Object> get props => [auth];
}

class Authenticated extends SignUpState {
  final AuthEntity auth;

  const Authenticated(this.auth);

  @override
  List<Object> get props => [auth];
}

class TenantNameValidated extends SignUpState {}

class TenantNameValidationError extends SignUpState {
  final String message;

  const TenantNameValidationError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object> get props => [message];
}

class EmailValidated extends SignUpState {}

class EmailValidationError extends SignUpState {
  final String message;

  const EmailValidationError(this.message);

  @override
  List<Object> get props => [message];
}

class PasswordValidated extends SignUpState {}

class PasswordValidationError extends SignUpState {
  final String message;

  const PasswordValidationError(this.message);

  @override
  List<Object> get props => [message];
}
class LoginInfoLoaded extends SignUpState {
  final LoginInfoEntity loginInfo;

  const LoginInfoLoaded(this.loginInfo);

  @override
  List<Object> get props => [loginInfo];
}