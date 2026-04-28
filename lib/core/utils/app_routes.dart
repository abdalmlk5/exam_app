// import 'package:exams_app/config/di/di.dart';
// import 'package:exams_app/features/authentication/presentation/auth/pages/auth_page.dart';
// import 'package:exams_app/features/authentication/presentation/forget_password/cubit/forget_password_cubit.dart';
// import 'package:exams_app/features/home_screen/presentation/pages/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../features/authentication/presentation/forget_password/pages/email_verification_page.dart';
// import '../../features/authentication/presentation/forget_password/pages/forget_password_page.dart';
// import '../../features/authentication/presentation/forget_password/pages/reset_password_page.dart';
// import '../../features/exams/domain/entities/exam_entity.dart';
// import '../../features/exams/presentation/pages/exam_details_page.dart';
// import '../../features/exams/presentation/pages/exams_page.dart';
//
// class AppRoutes {
//   static final GlobalKey<NavigatorState> navigatorKey =
//       GlobalKey<NavigatorState>();
//
//   static const String auth = '/auth';
//   static const String home = '/home';
//   static const String forgetPassword = '/forgetPassword';
//   static const String emailVerification = '/emailVerification';
//   static const String resetPassword = '/resetPassword';
//   static const String examsPage = '/examsPage';
//   static const String examDetailsPage = '/examDetailsPage';
//
//   static final ForgetPasswordCubit _forgetPasswordCubit =
//       getIt<ForgetPasswordCubit>();
//
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case auth:
//         return MaterialPageRoute(builder: (_) => const AuthPage());
//
//       case home:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//
//       case forgetPassword:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider.value(
//             value: _forgetPasswordCubit,
//             child: const ForgetPasswordPage(),
//           ),
//         );
//
//       case emailVerification:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider.value(
//             value: _forgetPasswordCubit,
//             child: const EmailVerificationPage(),
//           ),
//         );
//
//       case resetPassword:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider.value(
//             value: _forgetPasswordCubit,
//             child: const ResetPasswordPage(),
//           ),
//         );
//
//       case examsPage:
//         final subject = settings.arguments as String?;
//         return MaterialPageRoute(builder: (_) => ExamsPage(subject: subject));
//
//       case examDetailsPage:
//         final exam = settings.arguments as ExamEntity;
//         return MaterialPageRoute(builder: (_) => ExamDetailsPage(exam: exam));
//
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(child: Text('No route defined for ${settings.name}')),
//           ),
//         );
//     }
//   }
// }
