import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/error_handler/error_handler.dart';
import 'package:exam_app/core/utils/app_params.dart';
import 'package:exam_app/features/authentication/api/api_client/auth_api_client.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/auth_local_data_source.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/response/forget_password_models/forget_password_response.dart';
import '../../data/models/response/forget_password_models/reset_password_response.dart';
import '../../data/models/response/forget_password_models/verify_code_response.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient authApiClient;
  final AuthLocalDataSourceContract localDataSource;

  AuthRemoteDataSourceImpl({
    required this.authApiClient,
    required this.localDataSource,
  });

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(
    String email,
  ) async {
    try {
      final response = await authApiClient.forgetPassword({
        AppParams.email: email,
      });
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<VerifyCodeResponse>> verifyResetCode(String code) async {
    try {
      final response = await authApiClient.verifyResetCode({
        AppParams.resetCode: code,
      });
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  ) async {
    try {
      final response = await authApiClient.resetPassword({
        AppParams.email: email,
        AppParams.newPassword: newPassword,
      });
      return SuccessBaseResponse(response);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
