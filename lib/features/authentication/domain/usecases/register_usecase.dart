import 'package:exam_app/features/authentication/data/models/request/register_request.dart';
import 'package:exam_app/features/authentication/domain/entities/user_auth_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../repositories/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo repository;

  RegisterUseCase({required this.repository});

  Future<BaseResponse<UserAuthEntity>> call({
    required RegisterRequestModel registerRequest,
    required bool rememberMe,
  }) async {
    return await repository.register(
      registerRequest: registerRequest,
      rememberMe: rememberMe,
    );
  }
}
