sealed class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

class ForgetPasswordSendEmailEvent extends ForgetPasswordEvent {
  final String email;
  const ForgetPasswordSendEmailEvent(this.email);
}

class ForgetPasswordVerifyCodeEvent extends ForgetPasswordEvent {
  final String code;
  const ForgetPasswordVerifyCodeEvent(this.code);
}

class ForgetPasswordResetPasswordEvent extends ForgetPasswordEvent {
  final String password;
  final String confirmPassword;
  const ForgetPasswordResetPasswordEvent(this.password, this.confirmPassword);
}
