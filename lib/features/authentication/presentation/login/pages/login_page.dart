import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/utils/app_colors.dart';
import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exam_app/features/authentication/presentation/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppStrings.login, style: AppTextStyles.black20500),
        ),
        body: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
