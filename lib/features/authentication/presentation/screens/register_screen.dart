// lib/features/authentication/presentation/pages/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/router/route_paths.dart';
import 'package:workium/core/theme/app_text_styles.dart';
import 'package:workium/core/widgets/custom_elevated_button.dart';
import 'package:workium/features/authentication/domain/entities/password_complexity_entity.dart';
import 'package:workium/features/authentication/presentation/blocs/signup_bloc/sign_up_bloc.dart';
import 'package:workium/features/authentication/presentation/widgets/buttom_logo_and_text.dart';
import 'package:workium/features/authentication/presentation/widgets/register_screen_widgets/password_strength_meter.dart';
import 'package:workium/features/authentication/presentation/widgets/register_screen_widgets/password_validation_indecator.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/app_bar.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/title_section.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  String? _emailError;
  String? _passwordError;
  PasswordComplexityEntity? _passwordComplexity;

  @override
  void initState() {
    super.initState();
    // Load password complexity
    context.read<SignUpBloc>().add(GetPasswordComplexityEvent());

    // Listen to text changes
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    final email = _emailController.text;
    context.read<SignUpBloc>().add(ValidateEmailEvent(email));
  }

  void _onPasswordChanged() {
    final password = _passwordController.text;
    if (_passwordComplexity != null) {
      context.read<SignUpBloc>().add(
        ValidatePasswordEvent(
          password: password,
          complexity: _passwordComplexity!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is PasswordComplexityLoaded) {
          // Store password complexity for validation
          _passwordComplexity = state.complexity;
          // Validate password with loaded complexity
          _onPasswordChanged();
        }
      },
      builder: (context, state) {
        if (state is EmailValidated) {
          _isEmailValid = true;
          _emailError = null;
        } else if (state is EmailValidationError) {
          _isEmailValid = false;
          _emailError = state.message;
        }

        if (state is PasswordValidated) {
          _isPasswordValid = true;
          _passwordError = null;
        } else if (state is PasswordValidationError) {
          _isPasswordValid = false;
          _passwordError = state.message;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const BackBar(appBarTitle: ''),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16.h),
                        const TitleSection(title: 'Create your password'),
                        SizedBox(height: 80.h),

                        // Email Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your work email',
                              style: AppTextStyles.sectionTitle,
                            ),
                            SizedBox(height: 8.h),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'example@company.com',
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 16.w,
                                  minHeight: 16.h,
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 16.w,
                                  minHeight: 16.h,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: SvgPicture.asset(
                                    AppAssets.emailIcon,
                                    height: 16.h,
                                  ),
                                ),
                                suffixIcon: _emailController.text.isNotEmpty
                                    ? GestureDetector(
                                  onTap: () {
                                    _emailController.clear();
                                    _onEmailChanged();
                                  },
                                  child: SvgPicture.asset(
                                    AppAssets.xCircleIcon,
                                    height: 24.h,
                                  ),
                                )
                                    : null,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.uiGrayDarker,
                                    width: 1.0,
                                  ),
                                ),
                                errorText: _emailError,
                                errorStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.red,
                                ),
                              ),
                              style: AppTextStyles.sectionTitle,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your password',
                              style: AppTextStyles.sectionTitle,
                            ),
                            SizedBox(height: 8.h),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: '*****************',
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 16.w,
                                  minHeight: 16.h,
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 16.w,
                                  minHeight: 16.h,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: SvgPicture.asset(
                                    AppAssets.passwordIcon,
                                    height: 16.h,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    _obscurePassword
                                        ? AppAssets.eyeIcon
                                        : AppAssets.extIcon,
                                    height: 28.h,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.uiGrayDarker,
                                    width: 1.0,
                                  ),
                                ),
                                //errorText: _passwordError,
                                errorStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.red,
                                ),
                              ),
                              style: AppTextStyles.sectionTitle,
                            ),
                          ],
                        ),

                        SizedBox(height: 14.h),

                        // Password Strength & Validation
                        if (_passwordComplexity != null)
                          _buildPasswordValidation(),

                        SizedBox(height: 25.h),

                        // Confirm Password Button
                        CustomElevatedButton(
                          onPress: _isEmailValid && _isPasswordValid
                              ? () {
                            // Save email and password, move to workspace setup
                            Navigator.pushNamed(
                              context,
                              RoutePaths.workspaceSetup,
                              arguments: {
                                'email': _emailController.text,
                                'password': _passwordController.text,
                              },
                            );
                          }
                              : null,
                          title: 'Confirm password',
                          backgroundColor: _isEmailValid && _isPasswordValid
                              ? AppColors.primaryAzure
                              : AppColors.disabledButton,
                        ),

                        SizedBox(height: 43.h),
                        const ButtomLogoAndText(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordValidation() {
    if (_passwordComplexity == null) return const SizedBox();

    final password = _passwordController.text;
    final complexity = _passwordComplexity!;

    final hasMinLength = password.length >= complexity.requiredLength;
    final hasUppercase = !complexity.requireUppercase ||
        password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = !complexity.requireLowercase ||
        password.contains(RegExp(r'[a-z]'));
    final hasDigit = !complexity.requireDigit ||
        password.contains(RegExp(r'[0-9]'));
    final hasSpecial = !complexity.requireNonAlphanumeric ||
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    final strengthRatio = _calculatePasswordStrength(
      hasMinLength, hasUppercase, hasLowercase, hasDigit, hasSpecial,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordStrengthMeter(
          strengthRatio: strengthRatio,
          strengthColor: _getStrengthColor(strengthRatio),
          statusText: _getStatusText(strengthRatio),
        ),
        SizedBox(height: 6.h),
        PasswordValidationIndicator(
          text: 'Passwords must have at least ${complexity.requiredLength} characters',
          isValid: hasMinLength,
        ),
        SizedBox(height: 5.h),
        if (complexity.requireUppercase)
          PasswordValidationIndicator(
            text: 'Passwords must have at least one uppercase (\'A\'-\'Z\')',
            isValid: hasUppercase,
          ),
        if (complexity.requireLowercase)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: PasswordValidationIndicator(
              text: 'Passwords must have at least one lowercase (\'a\'-\'z\')',
              isValid: hasLowercase,
            ),
          ),
        if (complexity.requireDigit)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: PasswordValidationIndicator(
              text: 'Passwords must have at least one digit (0-9)',
              isValid: hasDigit,
            ),
          ),
        if (complexity.requireNonAlphanumeric)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: PasswordValidationIndicator(
              text: 'Passwords must have at least one special character',
              isValid: hasSpecial,
            ),
          ),
      ],
    );
  }

  double _calculatePasswordStrength(
      bool hasMinLength,
      bool hasUppercase,
      bool hasLowercase,
      bool hasDigit,
      bool hasSpecial,
      ) {
    int totalRequirements = 1; // Minimum length is always required
    int metRequirements = hasMinLength ? 1 : 0;

    if (_passwordComplexity != null) {
      final complexity = _passwordComplexity!;

      if (complexity.requireUppercase) totalRequirements++;
      if (complexity.requireLowercase) totalRequirements++;
      if (complexity.requireDigit) totalRequirements++;
      if (complexity.requireNonAlphanumeric) totalRequirements++;

      if (hasUppercase) metRequirements++;
      if (hasLowercase) metRequirements++;
      if (hasDigit) metRequirements++;
      if (hasSpecial) metRequirements++;
    }

    return metRequirements / totalRequirements;
  }

  Color _getStrengthColor(double strengthRatio) {
    if (strengthRatio < 0.5) return Colors.red;
    if (strengthRatio < 0.75) return Colors.orange;
    return Colors.green;
  }

  String _getStatusText(double strengthRatio) {
    if (strengthRatio < 0.5) return 'Weak password';
    if (strengthRatio < 0.75) return 'Medium strength';
    return 'Strong password';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}