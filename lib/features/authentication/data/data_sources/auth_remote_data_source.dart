import '../../../../config/base_response/base_response.dart';
import '../models/response/forget_password_models/forget_password_response.dart';
import '../models/response/forget_password_models/reset_password_response.dart';
import '../models/response/forget_password_models/verify_code_response.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(String email);
  Future<BaseResponse<VerifyCodeResponse>> verifyResetCode(String code);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  );
}
