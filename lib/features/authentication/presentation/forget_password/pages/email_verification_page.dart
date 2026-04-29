import 'package:exam_app/core/utils/app_colors.dart';
import 'package:exam_app/core/utils/app_routes.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/core/utils/app_text_styles.dart';
import 'package:exam_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/forget_password_cubit.dart';
import '../cubit/forget_password_event.dart';
import '../cubit/forget_password_state.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (prev, curr) =>
          prev.forgetPasswordState.data != curr.forgetPasswordState.data ||
          prev.forgetPasswordState.errorMessage !=
              curr.forgetPasswordState.errorMessage,
      listener: (context, state) {
        if (state.forgetPasswordState.errorMessage != null) {
          showErrorSnackBar(context, state.forgetPasswordState.errorMessage!);
          return;
        }
        if (state.forgetPasswordState.data != null) {
          Navigator.pushNamed(context, AppRoutes.resetPassword);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.password, style: AppTextStyles.black20500),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                AppStrings.emailVerification,
                style: AppTextStyles.black18500,
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.emailVerificationSubtitle,
                style: AppTextStyles.gray14400,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTextStyles.black18500,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: AppColors.blue10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.lightBlue,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                        if (_otpCode.length == 6) {
                          final cubit = context.read<ForgetPasswordCubit>();
                          if (!cubit.state.forgetPasswordState.isLoading) {
                            cubit.doEvent(
                              ForgetPasswordVerifyCodeEvent(_otpCode),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                builder: (context, state) {
                  if (state.forgetPasswordState.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.didntReceiveCode,
                    style: AppTextStyles.gray14400,
                  ),
                  TextButton(
                    onPressed: () {
                      // Resend logic
                    },
                    child: Text(
                      AppStrings.resend,
                      style: AppTextStyles.gray14400.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
