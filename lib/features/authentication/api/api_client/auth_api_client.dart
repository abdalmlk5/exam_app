import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/response/forget_password_models/forget_password_response.dart';
import '../../data/models/response/forget_password_models/reset_password_response.dart';
import '../../data/models/response/forget_password_models/verify_code_response.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(EndPoints.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST(EndPoints.verifyResetCode)
  Future<VerifyCodeResponse> verifyResetCode(@Body() Map<String, dynamic> body);

  @PUT(EndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() Map<String, dynamic> body,
  );
}
