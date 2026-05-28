import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/features/authentication/data/models/request/login_request.dart';
import 'package:exam_app/features/authentication/data/models/request/register_request.dart';
import 'package:exam_app/features/authentication/domain/entities/user_auth_entity.dart';

abstract interface class AuthRepo {
  Future<BaseResponse<UserAuthEntity>> login({
    required LoginRequestModel loginRequest,
    required bool rememberMe,
  });

  Future<BaseResponse<UserAuthEntity>> register({
    required RegisterRequestModel registerRequest,
    required bool rememberMe,
  });
}
