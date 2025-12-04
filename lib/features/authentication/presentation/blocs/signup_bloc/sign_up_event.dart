part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class GetEditionsEvent extends SignUpEvent {}

class GetPasswordComplexityEvent extends SignUpEvent {}

class CheckTenantAvailabilityEvent extends SignUpEvent {
  final String tenancyName;

  const CheckTenantAvailabilityEvent(this.tenancyName);

  @override
  List<Object> get props => [tenancyName];
}

class RegisterTenantEvent extends SignUpEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String tenantName;
  final String tenancyName;
  final String editionId;
  final String timeZone;

  const RegisterTenantEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.tenantName,
    required this.tenancyName,
    required this.editionId,
    required this.timeZone,
  });

  @override
  List<Object> get props => [
    email,
    password,
    firstName,
    lastName,
    tenantName,
    tenancyName,
    editionId,
    timeZone,
  ];
}

class AuthenticateEvent extends SignUpEvent {
  final String email;
  final String password;
  final String tenancyName;
  final String timeZone;

  const AuthenticateEvent({
    required this.email,
    required this.password,
    required this.tenancyName,
    required this.timeZone,
  });

  @override
  List<Object> get props => [email, password, tenancyName, timeZone];
}



class ValidateTenantNameEvent extends SignUpEvent {
  final String tenantName;

  const ValidateTenantNameEvent(this.tenantName);

  @override
  List<Object> get props => [tenantName];
}

class ValidateEmailEvent extends SignUpEvent {
  final String email;

  const ValidateEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ValidatePasswordEvent extends SignUpEvent {
  final String password;
  final PasswordComplexityEntity complexity;

  const ValidatePasswordEvent({
    required this.password,
    required this.complexity,
  });

  @override
  List<Object> get props => [password, complexity];
}
class GetCurrentLoginInfoEvent extends SignUpEvent {}
