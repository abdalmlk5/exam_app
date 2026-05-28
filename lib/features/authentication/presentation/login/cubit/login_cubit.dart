import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/error_handler/error_handler.dart';
import 'package:exam_app/features/authentication/data/models/request/login_request.dart';
import 'package:exam_app/features/authentication/domain/entities/user_auth_entity.dart';
import 'package:exam_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:exam_app/features/authentication/presentation/login/cubit/login_even.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(const LoginState());

  void doEvent(LoginEven event) {
    switch (event) {
      case Login():
        _login(email: event.email, password: event.password);
        break;
      case ToggleRememberMe():
        emit(state.copyWith(rememberMe: event.value));
        break;
    }
  }

  Future<void> _login({required String email, required String password}) async {
    try {
      emit(state.copyWith(loginState: const BaseState(isLoading: true)));

      final result = await _loginUseCase.call(
        loginRequest: LoginRequestModel(email: email, password: password),
        rememberMe: state.rememberMe,
      );

      switch (result) {
        case SuccessBaseResponse<UserAuthEntity>():
          emit(
            state.copyWith(
              loginState: BaseState(data: result.data, isLoading: false),
            ),
          );
        case ErrorBaseResponse<UserAuthEntity>():
          emit(
            state.copyWith(
              loginState: BaseState(
                isLoading: false,
                errorMessage: result.errorMessage,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loginState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e),
          ),
        ),
      );
    }
  }
}
