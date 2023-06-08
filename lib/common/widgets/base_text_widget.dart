import 'package:course_app/common/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget reusableText(String text,
    {Color color = AppColors.primaryText,
      int fontSize = 16,
      FontWeight fontWeight = FontWeight.bold}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize.sp,
    ),
  );
}