import 'package:exam_app/config/validations/app_validations.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final FieldType fieldType;
  final void Function(String)? onChanged;
  final Widget? suffix;
  final VoidCallback? onSuffixPressed;
  final TextEditingController? compareController;
  final bool readOnly;

  const AppTextField({
    super.key,
    required this.controller,
    required this.fieldType,
    this.onChanged,
    this.suffix,
    this.onSuffixPressed,
    this.compareController,
    this.readOnly = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;

  bool get _isPasswordField =>
      widget.fieldType == FieldType.password ||
      widget.fieldType == FieldType.newPassword ||
      widget.fieldType == FieldType.confirmPassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.fieldType.textInputType,
      onChanged: widget.onChanged,
      validator: _validate,
      obscureText: _isPasswordField && _isObscured,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.fieldType.label,
        hintText: widget.fieldType.hint,
        suffixIcon: _isPasswordField
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: theme.hintColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : widget.suffix,
      ),
    );
  }

  String? _validate(String? value) {
    switch (widget.fieldType) {
      case FieldType.email:
        return AppValidations.validateEmail(value);
      case FieldType.password:
        return AppValidations.validatePassword(value);
      case FieldType.newPassword:
        return AppValidations.validatePassword(value);
      case FieldType.profilePassword:
        return null;
      case FieldType.confirmPassword:
        return AppValidations.validateConfirmPassword(
          value,
          widget.compareController?.text,
        );
      case FieldType.username:
        return AppValidations.validateUserName(value);
      case FieldType.firstName:
        return AppValidations.validateFirstName(value);
      case FieldType.lastName:
        return AppValidations.validateLastName(value);
      case FieldType.phoneNumber:
        return AppValidations.validatePhoneNumber(value);
      case FieldType.none:
        return null;
      case FieldType.currentPassword:
        return AppValidations.validatePassword(value);
    }
  }
}

enum FieldType {
  email(
    AppStrings.email,
    AppStrings.enterYourEmail,
    TextInputType.emailAddress,
  ),
  password(
    AppStrings.password,
    AppStrings.enterYourPassword,
    TextInputType.text,
  ),
  newPassword(
    AppStrings.newPassword,
    AppStrings.newPassword,
    TextInputType.text,
  ),
  currentPassword(
    AppStrings.currentPassword,
    AppStrings.currentPassword,
    TextInputType.text,
  ),
  profilePassword(
    AppStrings.password,
    AppStrings.profilePassword,
    TextInputType.text,
  ),
  confirmPassword(
    AppStrings.confirmPassword,
    AppStrings.confirmPassword,
    TextInputType.text,
  ),
  username(
    AppStrings.userName,
    AppStrings.enterYourUserName,
    TextInputType.name,
  ),
  phoneNumber(
    AppStrings.phoneNumber,
    AppStrings.enterPhoneNumber,
    TextInputType.phone,
  ),
  firstName(
    AppStrings.firstName,
    AppStrings.enterFirstName,
    TextInputType.name,
  ),
  lastName(AppStrings.lastName, AppStrings.enterLastName, TextInputType.name),
  none('', '', TextInputType.text);

  final String label;
  final String hint;
  final TextInputType textInputType;
  const FieldType(this.label, this.hint, this.textInputType);
}
