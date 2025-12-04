import 'package:dio/dio.dart';
import 'package:workium/core/dio/dio_helper.dart';
import 'package:workium/core/error/app_exception.dart';
import 'package:workium/features/authentication/data/models/auth_model.dart';
import 'package:workium/features/authentication/data/models/edition_model.dart';
import 'package:workium/features/authentication/data/models/log_in_info_model.dart';
import 'package:workium/features/authentication/data/models/password_complexity_model.dart';
import 'package:workium/features/authentication/data/models/tenant_availability_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginInfoModel> getCurrentLoginInfo();
  Future<List<EditionModel>> getEditionsForSelect();
  Future<PasswordComplexityModel> getPasswordComplexity();
  Future<TenantAvailabilityModel> checkTenantAvailability(String tenancyName);
  Future<AuthModel> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required String editionId,
    required String name,
    required String tenancyName,
    required String timeZone,
  });
  Future<AuthModel> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenancyName,
    required String timeZone,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  AuthRemoteDataSourceImpl();

  @override
  Future<LoginInfoModel> getCurrentLoginInfo() async {
    try {
      final response = await DioHelper.getData(
        url: '/api/services/app/Session/GetCurrentLoginInformations',
      );

      if (response.statusCode == 200) {
        return LoginInfoModel.fromJson(response.data['result']);
      } else {
        throw ServerException(message: 'Failed to get login info');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['error']?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EditionModel>> getEditionsForSelect() async {
    try {
      final response = await DioHelper.getData(
        url: '/api/services/app/TenantRegistration/GetEditionsForSelect',
      );

      if (response.statusCode == 200) {
        final editionsData = response.data['result']['editionsWithFeatures'] as List;
        return editionsData
            .map((json) => EditionModel.fromJson(json))
            .toList();
      } else {
        throw ServerException(message: 'Failed to get editions');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['error']?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<PasswordComplexityModel> getPasswordComplexity() async {
    try {
      final response = await DioHelper.getData(
        url: '/api/services/app/Profile/GetPasswordComplexitySetting',
      );

      if (response.statusCode == 200) {
        return PasswordComplexityModel.fromJson(response.data['result']);
      } else {
        throw ServerException(message: 'Failed to get password complexity');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['error']?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TenantAvailabilityModel> checkTenantAvailability(String tenancyName) async {
    try {
      final response = await DioHelper.postData(
        url: '/api/services/app/Account/IsTenantAvailable',
        data: {'tenancyName': tenancyName},
      );

      if (response.statusCode == 200) {
        return TenantAvailabilityModel.fromJson(response.data['result']);
      } else {
        throw ServerException(message: 'Failed to check tenant availability');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['error']?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthModel> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required String editionId,
    required String name,
    required String tenancyName,
    required String timeZone,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: '/api/services/app/TenantRegistration/RegisterTenant',
        data: {
          'adminEmailAddress': adminEmailAddress,
          'adminFirstName': adminFirstName,
          'adminLastName': adminLastName,
          'adminPassword': adminPassword,
          'captchaResponse': null,
          'editionId': editionId,
          'name': name,
          'tenancyName': tenancyName,
          'timeZone': timeZone,
        },
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data['result']);
      } else {
        throw ServerException(message: 'Failed to register tenant');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['error']?['message'] ??
          e.response?.data?['error']?.toString() ??
          e.message ?? 'Registration failed';
      throw ServerException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<AuthModel> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenancyName,
    required String timeZone,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: '/api/TokenAuth/Authenticate',
        data: {
          'ianaTimeZone': timeZone,
          'password': password,
          'rememberClient': false,
          'returnUrl': null,
          'singleSignIn': false,
          'tenantName': tenancyName,
          'userNameOrEmailAddress': userNameOrEmailAddress,
        },
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data['result']);
      } else {
        throw ServerException(message: 'Authentication failed');
      }
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['error']?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }


}