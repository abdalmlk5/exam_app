import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:exam_app/features/authentication/data/models/request/login_request.dart';
import 'package:exam_app/features/authentication/data/models/request/register_request.dart';
import 'package:exam_app/features/authentication/domain/entities/user_auth_entity.dart';
import 'package:exam_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/user_model.dart';
import '../data_sources/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;
  final AuthLocalDataSourceContract authLocalDataSourceContract;

  AuthRepoImpl({
    required this.authRemoteDataSourceContract,
    required this.authLocalDataSourceContract,
  });

  @override
  Future<BaseResponse<UserAuthEntity>> login({
    required LoginRequestModel loginRequest,

    required bool rememberMe,
  }) async {
    final response = await authRemoteDataSourceContract.login(
      loginRequest: loginRequest,
      rememberMe: rememberMe,
    );

    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserAuthEntity>(response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserAuthEntity>(response.errorMessage);
    }
  }

  @override
  Future<BaseResponse<UserAuthEntity>> register({
    required RegisterRequestModel registerRequest,
    required rememberMe,
  }) async {
    final response = await authRemoteDataSourceContract.register(
      registerRequest: registerRequest,
      rememberMe: rememberMe,
    );

    switch (response) {
      case SuccessBaseResponse<UserModel>():
        return SuccessBaseResponse<UserAuthEntity>(response.data.toEntity());
      case ErrorBaseResponse<UserModel>():
        return ErrorBaseResponse<UserAuthEntity>(response.errorMessage);
    }
  }
}
