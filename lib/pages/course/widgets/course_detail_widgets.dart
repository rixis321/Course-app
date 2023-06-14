import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

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

Widget menuView(){
  return SizedBox(
    width: 325.w,

    child: Row(
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w, vertical: 5.h
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.primaryElement)
            ),
            child: reusableText("Author Page",
            color: AppColors.primaryElementText,
              fontWeight: FontWeight.normal,
              fontSize: 10.sp
            ),
          ),
        ),
        _iconAndNum("assets/icons/people.png", 0),
        _iconAndNum("assets/icons/star.png", 0)
      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num){
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(iconPath),
          width: 20.w,
          height: 20.h,
        ),
        reusableText(
            num.toString(),
          color: AppColors.primaryThreeElementText,
          fontSize: 11.sp,
          fontWeight: FontWeight.normal
        ),
      ],
    ),
  );
}

Widget descriptionText(){
  return reusableText("Course DescriptionCourse DescriptionCourse DescriptionCourse DescriptionCourse DescriptionCourse DescriptionCourse DescriptionCourse DescriptionCourse DescriptionCourse Description",
      color: AppColors.primaryThreeElementText,
      fontWeight: FontWeight.normal,
      fontSize: 11.sp
  );
}

Widget goBuyButton(String name){
  return Container(
    padding: EdgeInsets.only(top: 13.h),
    width: 330.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColors.primaryElement,
      borderRadius: BorderRadius.circular(10.w),
      border: Border.all(
        color: AppColors.primaryElement
      )
    ),
    child: Text(
      name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryElementText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget courseSummary(){
  return reusableText("The Course Includes", fontSize: 14.sp);
}

var imagesInfo =<String,String>{
  "36 Hours Video":"video_detail.png",
  "Total 30 Lessons":"file_detail.png",
  "67 Downloadable Resources":"download_detail.png",
};

Widget buildListView(BuildContext context){
  return Column(
    children: [
      ...List.generate(imagesInfo.length, (index) =>  GestureDetector(
        onTap: ()=>null,
        child: Container(
          margin: EdgeInsets.only(top: 15.w),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.primaryElement
                ),
                child: Image.asset("assets/icons/${imagesInfo.values.elementAt(index)}",
                  width: 30.w,
                  height: 30.h,
                ),
              ),
              SizedBox(width: 15.w,),
              Text(
                  imagesInfo.keys.elementAt(index),
                  style: TextStyle(
                      color: AppColors.primarySecondaryElementText,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp
                  ))
            ],
          ),
        ),
      ),)
    ],
  );
}