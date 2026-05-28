import 'package:exam_app/core/utils/app_routes.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_text_field.dart';
import 'package:exam_app/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:exam_app/features/authentication/presentation/register/cubit/register_even.dart';
import 'package:exam_app/features/authentication/presentation/register/widgets/remember_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../auth_widgets/auth_footer.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register() {
    context.read<RegisterCubit>().doEvent(
      Register(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        rePassword: _rePasswordController.text,
        phone: _phoneController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          previous.registerState != current.registerState,
      listener: (context, state) {
        if (state.registerState.data != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
          showSuccessSnackBar(context, AppStrings.registerSuccess);
        } else if (state.registerState.errorMessage != null) {
          showErrorSnackBar(context, state.registerState.errorMessage!);
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: _usernameController,
                fieldType: FieldType.username,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _firstNameController,
                      fieldType: FieldType.firstName,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: AppTextField(
                      controller: _lastNameController,
                      fieldType: FieldType.lastName,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _emailController,
                fieldType: FieldType.email,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _passwordController,
                      fieldType: FieldType.password,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: AppTextField(
                      controller: _rePasswordController,
                      fieldType: FieldType.confirmPassword,
                      compareController: _passwordController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              AppTextField(
                controller: _phoneController,
                fieldType: FieldType.phoneNumber,
              ),
              const SizedBox(height: 12),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.rememberMe != current.rememberMe,
                builder: (context, state) {
                  return RememberMe(
                    value: state.rememberMe,
                    onChanged: (value) {
                      context.read<RegisterCubit>().doEvent(
                        ToggleRememberMe(value ?? false),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 48.h),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.registerState.isLoading !=
                        current.registerState.isLoading ||
                    previous.isButtonEnabled != current.isButtonEnabled,
                builder: (context, state) {
                  return CustomButton(
                    text: AppStrings.signup,
                    isEnabled: state.isButtonEnabled,
                    isLoading: state.registerState.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _register();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 24.h),
              AuthFooter(
                text: AppStrings.alreadyHaveAccount,
                linkText: AppStrings.login,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
