import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(){
  return AppBar(
    title: reusableText("Course detail"),
  );
}

Widget thumbNail(){
  return Container(
    width: 325.w,
    height: 200.h,
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
                "assets/icons/Image(1).png"
            )
        )
    ),
  );
}