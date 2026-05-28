import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/utils/app_colors.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:exam_app/features/authentication/presentation/register/widgets/register_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_text_styles.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppStrings.signup, style: AppTextStyles.black20500),
        ),
        body: SafeArea(child: RegisterViewBody()),
      ),
    );
  }
}
