part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BaseState<UserAuthEntity> loginState;
  final bool isButtonEnabled;
  final bool rememberMe;

  const LoginState({
    this.loginState = const BaseState(),
    this.isButtonEnabled = true,
    this.rememberMe = false,
  });

  LoginState copyWith({
    BaseState<UserAuthEntity>? loginState,
    bool? isButtonEnabled,
    bool? rememberMe,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [loginState, isButtonEnabled, rememberMe];
}
