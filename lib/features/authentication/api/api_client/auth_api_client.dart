import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/response/login_register_responses/auth_response.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(EndPoints.signin)
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @POST(EndPoints.register)
  Future<AuthResponseModel> register(@Body() Map<String, dynamic> body);
}
