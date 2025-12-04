// lib/features/authentication/presentation/pages/workspace_setup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workium/core/constants/app_assets.dart';
import 'package:workium/core/constants/app_colors.dart';
import 'package:workium/core/router/route_paths.dart';
import 'package:workium/core/widgets/custom_elevated_button.dart';
import 'package:workium/core/widgets/custom_text_field.dart';
import 'package:workium/features/authentication/presentation/blocs/signup_bloc/sign_up_bloc.dart';
import 'package:workium/features/authentication/presentation/widgets/buttom_logo_and_text.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/app_bar.dart';
import 'package:workium/features/authentication/presentation/widgets/sign_in_screen_widgets/title_section.dart';

class WorkspaceSetupScreen extends StatefulWidget {
  final String email;
  final String password;

  const WorkspaceSetupScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<WorkspaceSetupScreen> createState() => _WorkspaceSetupScreenState();
}

class _WorkspaceSetupScreenState extends State<WorkspaceSetupScreen> {
  final TextEditingController _tenantNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _selectedEditionId;
  List<String> _validationErrors = [];
  bool _isLoading = false;
  bool _isTenantAvailable = true;

  @override
  void initState() {
    super.initState();
    // Load editions - but don't show them to user
    context.read<SignUpBloc>().add(GetEditionsEvent());

    // Add listeners to text controllers
    _tenantNameController.addListener(_onFieldChanged);
    _firstNameController.addListener(_onFieldChanged);
    _lastNameController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    _validateFields();
  }

  void _validateFields() {
    final errors = <String>[];

    // Validate tenant name
    final tenantName = _tenantNameController.text.trim();
    if (tenantName.isEmpty) {
      errors.add('Workspace name is required');
    } else if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9\-]*$').hasMatch(tenantName)) {
      errors.add('Workspace name must start with a letter and can only contain letters, numbers, and dashes');
    }

    // Validate first name
    final firstName = _firstNameController.text.trim();
    if (firstName.isEmpty) {
      errors.add('First name is required');
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(firstName)) {
      errors.add('First name can only contain letters');
    }

    // Validate last name
    final lastName = _lastNameController.text.trim();
    if (lastName.isEmpty) {
      errors.add('Last name is required');
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(lastName)) {
      errors.add('Last name can only contain letters');
    }

    // Check if we have a selected edition
    if (_selectedEditionId == null) {
      errors.add('No edition available for registration');
    }

    if (!_isTenantAvailable) {
      errors.add('This workspace name is already taken');
    }

    if (mounted) {
      setState(() {
        _validationErrors = errors;
      });
    }
  }

  bool get _canSubmit {
    return _validationErrors.isEmpty &&
        _selectedEditionId != null &&
        _tenantNameController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _isTenantAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is EditionsLoaded) {
          final registrableEditions = state.editions.where((e) => e.isRegistrable).toList();
          if (registrableEditions.isNotEmpty && _selectedEditionId == null) {
            _selectedEditionId = registrableEditions.first.id;
            _validateFields();
          }
        } else if (state is TenantAvailabilityChecked) {
          setState(() {
            _isTenantAvailable = state.availability.tenantId==null&&_tenantNameController.text.isNotEmpty;
          });
          _validateFields();
        } else if (state is TenantRegistered) {
          // After registration, authenticate
          context.read<SignUpBloc>().add(AuthenticateEvent(
            email: widget.email,
            password: widget.password,
            tenancyName: _tenantNameController.text.trim(),
            timeZone: 'UTC', // You can get device timezone
          ));
        } else if (state is Authenticated) {
          // Navigate to welcome screen
          Navigator.pushNamed(
            context,
            RoutePaths.welcomeMessage,
          );
        } else if (state is SignUpError) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is SignUpLoading) {
          setState(() {
            //_isLoading = true;
          });
        }
      },
      builder: (context, state) {
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
                        SizedBox(height: 40.h),
                        const TitleSection(title: 'Enter your company name'),
                        SizedBox(height: 80.h),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Workspace Name
                            CustomInputField(
                              title: 'Your company or team name',
                              svgPrefixIcon: AppAssets.communityIcon,
                              hintText: 'Workspace name*',
                              svgSuffixIcon: AppAssets.extIcon,
                              controller: _tenantNameController,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  context.read<SignUpBloc>().add(
                                    CheckTenantAvailabilityEvent(value),
                                  );
                                }
                              },
                            ),

                            // Tenant Availability Status
                            BlocBuilder<SignUpBloc, SignUpState>(
                              buildWhen: (previous, current) =>
                              current is TenantAvailabilityChecked,
                              builder: (context, state) {
                                if (state is TenantAvailabilityChecked) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      state.availability.tenantId==null
                                          ? '✅ Available'
                                          : '❌ Already taken',
                                      style: TextStyle(
                                        color: state.availability.tenantId==null
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),

                            SizedBox(height: 24.h),

                            // First Name
                            CustomInputField(
                              title: 'Your first name',
                              svgPrefixIcon: AppAssets.linesIcon,
                              hintText: 'Enter your First name',
                              controller: _firstNameController,
                            ),

                            SizedBox(height: 24.h),

                            // Last Name
                            CustomInputField(
                              title: 'Your last name',
                              svgPrefixIcon: AppAssets.linesIcon,
                              hintText: 'Enter your Last name',
                              controller: _lastNameController,
                            ),
                          ],
                        ),

                        // Show validation errors if any
                        if (_validationErrors.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _validationErrors.map((error) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 4.h),
                                  child: Text(
                                    '• $error',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                        SizedBox(height: 25.h),

                        // Create Workspace Button
                        CustomElevatedButton(
                          onPress: _canSubmit && !_isLoading
                              ? _submitRegistration
                              : null,
                          title: _isLoading ? 'Creating...' : 'Create Workspace',
                          backgroundColor: _canSubmit && !_isLoading
                              ? AppColors.primaryAzure
                              : AppColors.disabledButton,
                        ),

                        SizedBox(height: 55.h),
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

  void _submitRegistration() {
    // Check tenant availability first
    if (!_isTenantAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This workspace name is already taken'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Set loading state
    setState(() {
      _isLoading = true;
    });

    // Register tenant with the selected edition
    context.read<SignUpBloc>().add(
      RegisterTenantEvent(
        email: widget.email,
        password: widget.password,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        tenantName: _tenantNameController.text.trim(),
        tenancyName: _tenantNameController.text.trim(),
        editionId: _selectedEditionId!,
        timeZone: 'UTC', // You can get device timezone
      ),
    );
  }

  @override
  void dispose() {
    _tenantNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}