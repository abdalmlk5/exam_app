part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final BaseState<UserAuthEntity> registerState;
  final bool isButtonEnabled;
  final bool rememberMe;

  const RegisterState({
    this.registerState = const BaseState(),
    this.isButtonEnabled = true,
    this.rememberMe = false,
  });

  RegisterState copyWith({
    BaseState<UserAuthEntity>? registerState,
    bool? isButtonEnabled,
    bool? rememberMe,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [registerState, isButtonEnabled, rememberMe];
}
