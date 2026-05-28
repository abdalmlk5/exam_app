import 'package:exam_app/features/authentication/data/models/request/login_request.dart';
import 'package:exam_app/features/authentication/domain/entities/user_auth_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../repositories/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo repository;

  LoginUseCase({required this.repository});

  Future<BaseResponse<UserAuthEntity>> call({
    required LoginRequestModel loginRequest,
    required bool rememberMe,
  }) async {
    return await repository.login(
      loginRequest: loginRequest,
      rememberMe: rememberMe,
    );
  }
}
