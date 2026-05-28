import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/error_handler/error_handler.dart';
import 'package:exam_app/features/authentication/data/models/request/register_request.dart';
import 'package:exam_app/features/authentication/domain/entities/user_auth_entity.dart';
import 'package:exam_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:exam_app/features/authentication/presentation/register/cubit/register_even.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterState());

  void doEvent(RegisterEven event) {
    switch (event) {
      case Register():
        _register(event);
        break;
      case ChangeButtonStatus():
        emit(state.copyWith(isButtonEnabled: event.isEnabled));
        break;
      case ToggleRememberMe():
        emit(state.copyWith(rememberMe: event.value));
        break;
    }
  }

  Future<void> _register(Register event) async {
    try {
      emit(state.copyWith(registerState: const BaseState(isLoading: true)));

      final request = RegisterRequestModel(
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        rePassword: event.rePassword,
        phone: event.phone,
      );

      final result = await _registerUseCase.call(
        registerRequest: request,
        rememberMe: state.rememberMe,
      );

      switch (result) {
        case SuccessBaseResponse<UserAuthEntity>():
          emit(
            state.copyWith(
              registerState: BaseState(data: result.data, isLoading: false),
            ),
          );
        case ErrorBaseResponse<UserAuthEntity>():
          emit(
            state.copyWith(
              registerState: BaseState(
                isLoading: false,
                errorMessage: result.errorMessage,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          registerState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e),
          ),
        ),
      );
    }
  }
}
