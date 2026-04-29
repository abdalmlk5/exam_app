import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:exam_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/auth_remote_data_source.dart';
import '../models/response/forget_password_models/forget_password_response.dart';
import '../models/response/forget_password_models/reset_password_response.dart';
import '../models/response/forget_password_models/verify_code_response.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;
  final AuthLocalDataSourceContract authLocalDataSourceContract;

  AuthRepoImpl({
    required this.authRemoteDataSourceContract,
    required this.authLocalDataSourceContract,
  });

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(String email) {
    return authRemoteDataSourceContract.forgetPassword(email);
  }

  @override
  Future<BaseResponse<VerifyCodeResponse>> verifyCode(String code) {
    return authRemoteDataSourceContract.verifyResetCode(code);
  }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  ) {
    return authRemoteDataSourceContract.resetPassword(email, newPassword);
  }

  @override
  Future<bool> isRemembered() async {
    return authLocalDataSourceContract.getRememberMe();
  }
}
