import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/features/authentication/domain/usecases/forget_password_use_case.dart';
import 'package:exam_app/features/authentication/domain/usecases/verify_code_use_case.dart';
import 'package:exam_app/features/authentication/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../domain/usecases/reset_password_use_case.dart';
import 'forget_password_event.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  String? _userEmail;

  ForgetPasswordCubit(
    this._forgetPasswordUseCase,
    this._verifyCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(ForgetPasswordState());

  void doEvent(ForgetPasswordEvent event) {
    switch (event) {
      case ForgetPasswordSendEmailEvent():
        _forgetPassword(event.email);
        break;
      case ForgetPasswordVerifyCodeEvent():
        _verifyCode(event.code);
        break;
      case ForgetPasswordResetPasswordEvent():
        _resetPassword(event.password, event.confirmPassword);
        break;
    }
  }

  void _forgetPassword(String email) async {
    emit(state.copyWith(stateParam: const BaseState<String?>(isLoading: true)));

    final result = await _forgetPasswordUseCase.call(email);
    switch (result) {
      case SuccessBaseResponse():
        _userEmail = email;
        emit(
          state.copyWith(
            stateParam: BaseState<String?>(data: result.data.info),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<String?>(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  void _verifyCode(String code) async {
    emit(state.copyWith(stateParam: const BaseState<String?>(isLoading: true)));
    final result = await _verifyCodeUseCase.call(code);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<String?>(data: result.data.status),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<String?>(errorMessage: result.errorMessage),
          ),
        );
    }
  }

  void _resetPassword(String password, String confirmPassword) async {
    if (password != confirmPassword) {
      emit(
        state.copyWith(
          stateParam: const BaseState<String?>(
            errorMessage: AppStrings.passwordNotMatched,
          ),
        ),
      );
      return;
    }

    if (_userEmail == null) {
      emit(
        state.copyWith(
          stateParam: const BaseState<String?>(
            errorMessage: "Email is missing, please go back to step 1",
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(stateParam: const BaseState<String?>(isLoading: true)));

    final result = await _resetPasswordUseCase.call(_userEmail!, password);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<String?>(data: result.data.message),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<String?>(errorMessage: result.errorMessage),
          ),
        );
    }
  }
}
