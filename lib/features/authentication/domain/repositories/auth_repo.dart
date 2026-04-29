import 'package:exam_app/config/base_response/base_response.dart';

import '../../data/models/response/forget_password_models/forget_password_response.dart';
import '../../data/models/response/forget_password_models/reset_password_response.dart';
import '../../data/models/response/forget_password_models/verify_code_response.dart';

abstract interface class AuthRepo {
  Future<BaseResponse<ForgetPasswordResponse>> forgetPassword(String email);
  Future<BaseResponse<VerifyCodeResponse>> verifyCode(String code);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String newPassword,
  );
  Future<bool> isRemembered();
}
