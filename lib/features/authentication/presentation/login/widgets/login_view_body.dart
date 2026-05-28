import 'package:exam_app/core/utils/app_routes.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_text_field.dart';
import 'package:exam_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exam_app/features/authentication/presentation/login/cubit/login_even.dart';
import 'package:exam_app/features/authentication/presentation/login/widgets/remember_me_and_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../auth_widgets/auth_footer.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    context.read<LoginCubit>().doEvent(
      Login(email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.loginState != current.loginState,
      listener: (context, state) {
        if (state.loginState.data != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
          showSuccessSnackBar(context, AppStrings.loginSuccess);
        } else if (state.loginState.errorMessage != null) {
          showErrorSnackBar(context, state.loginState.errorMessage!);
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
                controller: _emailController,
                fieldType: FieldType.email,
              ),
              SizedBox(height: 24.h),
              AppTextField(
                controller: _passwordController,
                fieldType: FieldType.password,
              ),
              const SizedBox(height: 12),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return RememberMeAndForgetPassword(
                    value: state.rememberMe,
                    onChanged: (value) {
                      context.read<LoginCubit>().doEvent(
                        ToggleRememberMe(value ?? false),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 48.h),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomButton(
                    text: AppStrings.login,
                    isEnabled: state.isButtonEnabled,
                    isLoading: state.loginState.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 24.h),
              AuthFooter(
                text: AppStrings.dontHaveAccount,
                linkText: AppStrings.signup,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
