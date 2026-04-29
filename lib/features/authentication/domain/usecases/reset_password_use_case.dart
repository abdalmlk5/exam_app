import 'package:exam_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/forget_password_models/reset_password_response.dart';
import '../repositories/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo repository;

  ResetPasswordUseCase(this.repository);

  Future<BaseResponse<ResetPasswordResponse>> call(
    String email,
    String newPassword,
  ) {
    return repository.resetPassword(email, newPassword);
  }
}
