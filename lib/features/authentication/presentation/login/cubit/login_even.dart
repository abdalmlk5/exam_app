sealed class LoginEven {}

class Login extends LoginEven {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class ToggleRememberMe extends LoginEven {
  final bool value;
  ToggleRememberMe(this.value);
}
