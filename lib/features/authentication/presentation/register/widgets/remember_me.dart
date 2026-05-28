import 'package:exam_app/core/utils/app_strings.dart';
import 'package:exam_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMe extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMe({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(value: value, onChanged: onChanged),
        ),
        SizedBox(width: 8.w),
        Text(AppStrings.rememberMe, style: AppTextStyles.black13400),
      ],
    );
  }
}
