import 'package:exam_app/core/utils/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/cache/cache_helper.dart';
import 'config/di/di.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final cacheHelper = getIt<CacheHelper>();
  final token = await cacheHelper.readData(key: AppKeys.tokenKey);
  final bool isRemembered =
      await cacheHelper.readData(key: AppKeys.rememberMeKey) == 'true';
  final isLoggedIn = token != null && token.isNotEmpty && isRemembered;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.mainTheme,
          debugShowCheckedModeBanner: false,
          title: 'Exams App',
          onGenerateRoute: AppRoutes.onGenerateRoute,
          // initialRoute: isLoggedIn
          //     //todo: if user is logged in, return home screen
          //     ? AppRoutes.home
          //     //todo: if user is not logged in, return login screen
          //     : AppRoutes.login,
        );
      },
    );
  }
}
