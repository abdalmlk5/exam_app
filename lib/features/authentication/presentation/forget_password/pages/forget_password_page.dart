import 'package:exam_app/core/utils/app_routes.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/core/utils/app_text_styles.dart';
import 'package:exam_app/core/widgets/custom_snack_bar.dart';
import 'package:exam_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../cubit/forget_password_cubit.dart';
import '../cubit/forget_password_event.dart';
import '../cubit/forget_password_state.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
          Navigator.pushNamed(context, AppRoutes.emailVerification);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.password, style: AppTextStyles.black20500),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Text(
                  AppStrings.forgetPassword,
                  style: AppTextStyles.black18500,
                ),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.forgetPasswordSubtitle,
                  style: AppTextStyles.gray14400,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: emailController,
                  fieldType: FieldType.email,
                ),
                const Spacer(),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    return CustomButton(
                      isEnabled: true,
                      isLoading: state.forgetPasswordState.isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgetPasswordCubit>().doEvent(
                            ForgetPasswordSendEmailEvent(emailController.text),
                          );
                        }
                      },
                      text: AppStrings.continueText,
                    );
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
