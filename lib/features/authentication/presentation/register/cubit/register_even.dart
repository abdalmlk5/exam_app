sealed class RegisterEven {}

class Register extends RegisterEven {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  Register({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });
}

class ChangeButtonStatus extends RegisterEven {
  final bool isEnabled;
  ChangeButtonStatus(this.isEnabled);
}

class ToggleRememberMe extends RegisterEven {
  final bool value;
  ToggleRememberMe(this.value);
}
