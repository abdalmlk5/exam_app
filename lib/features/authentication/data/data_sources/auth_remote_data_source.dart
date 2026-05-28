import '../../../../config/base_response/base_response.dart';
import '../../../../core/models/user_model.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<BaseResponse<UserModel>> login({
    required LoginRequestModel loginRequest,
    required bool rememberMe,
  });

  Future<BaseResponse<UserModel>> register({
    required RegisterRequestModel registerRequest,
    required bool rememberMe,
  });
}
