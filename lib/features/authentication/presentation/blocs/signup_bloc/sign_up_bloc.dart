
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:workium/core/error/failure.dart';
import 'package:workium/core/usecases/usecase.dart';
import 'package:workium/features/authentication/domain/entities/auth_entity.dart';
import 'package:workium/features/authentication/domain/entities/edition_entity.dart';
import 'package:workium/features/authentication/domain/entities/login_info_entity.dart';
import 'package:workium/features/authentication/domain/entities/password_complexity_entity.dart';
import 'package:workium/features/authentication/domain/entities/tenant_availability_entity.dart';
import 'package:workium/features/authentication/domain/use_cases/authentication_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/check_tenant_availability_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/get_edition_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/get_login_info_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/get_password_complexity_usecase.dart';
import 'package:workium/features/authentication/domain/use_cases/register_tenant_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final GetEditionsUseCase getEditionsUseCase;
  final GetPasswordComplexityUseCase getPasswordComplexityUseCase;
  final CheckTenantAvailabilityUseCase checkTenantAvailabilityUseCase;
  final RegisterTenantUseCase registerTenantUseCase;
  final AuthenticateUseCase authenticateUseCase;
  final GetLoginInfoUseCase getCurrentLoginInfoUseCase;

  SignUpBloc({
    required this.getEditionsUseCase,
    required this.getPasswordComplexityUseCase,
    required this.checkTenantAvailabilityUseCase,
    required this.registerTenantUseCase,
    required this.authenticateUseCase,
    required this.getCurrentLoginInfoUseCase,
  }) : super(SignUpInitial()) {
    on<GetEditionsEvent>(_onGetEditions);
    on<GetPasswordComplexityEvent>(_onGetPasswordComplexity);
    on<CheckTenantAvailabilityEvent>(_onCheckTenantAvailability);
    on<RegisterTenantEvent>(_onRegisterTenant);
    on<AuthenticateEvent>(_onAuthenticate);
    on<ValidateEmailEvent>(_onValidateEmail);
    on<ValidatePasswordEvent>(_onValidatePassword);
    on<ValidateTenantNameEvent>(_onValidateTenantName);
    on<GetCurrentLoginInfoEvent>(_onGetCurrentLoginInfo);

  }


  Future<void> _onGetCurrentLoginInfo(
      GetCurrentLoginInfoEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    final result = await getCurrentLoginInfoUseCase(NoParams());
    _handleResult(result, emit, (loginInfo) => LoginInfoLoaded(loginInfo));
  }

  Future<void> _onGetEditions(
      GetEditionsEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    final result = await getEditionsUseCase(NoParams());
    _handleResult(result, emit, (editions) => EditionsLoaded(editions));
  }

  Future<void> _onGetPasswordComplexity(
      GetPasswordComplexityEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    final result = await getPasswordComplexityUseCase(NoParams());
    _handleResult(
        result, emit, (complexity) => PasswordComplexityLoaded(complexity));
  }

  Future<void> _onCheckTenantAvailability(
      CheckTenantAvailabilityEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    final result = await checkTenantAvailabilityUseCase(event.tenancyName);
    _handleResult(
        result, emit, (availability) => TenantAvailabilityChecked(availability));
  }

  Future<void> _onRegisterTenant(
      RegisterTenantEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    final params = RegisterTenantParams(
      adminEmailAddress: event.email,
      adminFirstName: event.firstName,
      adminLastName: event.lastName,
      adminPassword: event.password,
      editionId: event.editionId,
      name: event.tenantName,
      tenancyName: event.tenancyName,
      timeZone: event.timeZone,
    );
    final result = await registerTenantUseCase(params);
    _handleResult(result, emit, (auth) => TenantRegistered(auth));
  }

  Future<void> _onAuthenticate(
      AuthenticateEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());
    final params = AuthenticateParams(
      userNameOrEmailAddress: event.email,
      password: event.password,
      tenancyName: event.tenancyName,
      timeZone: event.timeZone,
    );
    final result = await authenticateUseCase(params);
    _handleResult(result, emit, (auth) => Authenticated(auth));
  }

  void _onValidateEmail(
      ValidateEmailEvent event,
      Emitter<SignUpState> emit,
      ) {
    final email = event.email;
    if (email.isEmpty) {
      emit(EmailValidationError('Email is required'));
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emit(EmailValidationError('Please enter a valid email'));
    } else {
      emit(EmailValidated());
    }
  }

  void _onValidatePassword(
      ValidatePasswordEvent event,
      Emitter<SignUpState> emit,
      ) {
    final password = event.password;
    final complexity = event.complexity;

    if (password.isEmpty) {
      emit(PasswordValidationError('Password is required'));
      return;
    }

    List<String> errors = [];

    if (password.length < complexity.requiredLength) {
      errors.add('Password must be at least ${complexity.requiredLength} characters');
    }
    if (complexity.requireUppercase && !password.contains(RegExp(r'[A-Z]'))) {
      errors.add('Password must contain uppercase letters');
    }
    if (complexity.requireLowercase && !password.contains(RegExp(r'[a-z]'))) {
      errors.add('Password must contain lowercase letters');
    }
    if (complexity.requireDigit && !password.contains(RegExp(r'[0-9]'))) {
      errors.add('Password must contain numbers');
    }
    if (complexity.requireNonAlphanumeric && !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('Password must contain special characters');
    }

    if (errors.isEmpty) {
      emit(PasswordValidated());
    } else {
      emit(PasswordValidationError(errors.join('\n')));
    }
  }

  void _onValidateTenantName(
      ValidateTenantNameEvent event,
      Emitter<SignUpState> emit,
      ) {
    final tenantName = event.tenantName;

    if (tenantName.isEmpty) {
      emit(TenantNameValidationError('Tenant name is required'));
    } else if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9\-]*$').hasMatch(tenantName)) {
      emit(TenantNameValidationError('Must start with letter and contain only letters, numbers, and dashes'));
    } else {
      emit(TenantNameValidated());
    }
  }

  void _handleResult<T>(
      Either<Failure, T> result,
      Emitter<SignUpState> emit,
      Function(T) onSuccess,
      ) {
    result.fold(
          (failure) => emit(SignUpError(_mapFailureToMessage(failure))),
          (data) => emit(onSuccess(data)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      case NetworkFailure:
        return 'Network error: ${failure.message}';
      case CacheFailure:
        return 'Cache error: ${failure.message}';
      case ValidationFailure:
        return 'Validation error: ${failure.message}';
      default:
        return 'Unexpected error: ${failure.message}';
    }
  }
}