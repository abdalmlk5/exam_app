import 'package:exam_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/forget_password_models/verify_code_response.dart';
import '../repositories/auth_repo.dart';

@injectable
class VerifyCodeUseCase {
  final AuthRepo repository;

  VerifyCodeUseCase(this.repository);

  Future<BaseResponse<VerifyCodeResponse>> call(String code) {
    return repository.verifyCode(code);
  }
}
