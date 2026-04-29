import 'package:exam_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/forget_password_models/forget_password_response.dart';
import '../repositories/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo repository;

  ForgetPasswordUseCase(this.repository);

  Future<BaseResponse<ForgetPasswordResponse>> call(String email) {
    return repository.forgetPassword(email);
  }
}
