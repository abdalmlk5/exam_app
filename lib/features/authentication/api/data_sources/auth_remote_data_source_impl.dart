import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/error_handler/error_handler.dart';
import 'package:exam_app/features/authentication/api/api_client/auth_api_client.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/app_params.dart';
import '../../data/data_sources/auth_local_data_source.dart';
import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/request/login_request.dart';
import '../../data/models/request/register_request.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient authApiClient;
  final AuthLocalDataSourceContract localDataSource;

  AuthRemoteDataSourceImpl({
    required this.authApiClient,
    required this.localDataSource,
  });

  @override
  Future<BaseResponse<UserModel>> login({
    required LoginRequestModel loginRequest,
    required bool rememberMe,
  }) async {
    try {
      final response = await authApiClient.login({
        AppParams.email: loginRequest.email,
        AppParams.password: loginRequest.password,
      });

      if (response.token != null) {
        await localDataSource.saveToken(response.token!);
        await localDataSource.saveRememberMe(rememberMe);
      }

      return SuccessBaseResponse<UserModel>(response.user);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<UserModel>> register({
    required RegisterRequestModel registerRequest,
    required bool rememberMe,
  }) async {
    try {
      final response = await authApiClient.register({
        AppParams.username: registerRequest.username,
        AppParams.firstName: registerRequest.firstName,
        AppParams.lastName: registerRequest.lastName,
        AppParams.email: registerRequest.email,
        AppParams.password: registerRequest.password,
        AppParams.rePassword: registerRequest.rePassword,
        AppParams.phone: registerRequest.phone,
      });

      if (response.token != null) {
        await localDataSource.saveToken(response.token!);
        await localDataSource.saveRememberMe(rememberMe);
      }

      return SuccessBaseResponse<UserModel>(response.user);
    } catch (e) {
      return ErrorBaseResponse(ErrorHandler.handle(e));
    }
  }
}
