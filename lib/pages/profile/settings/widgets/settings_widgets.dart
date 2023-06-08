import 'package:course_app/common/values/colors.dart';
import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(){
  return AppBar(
    title: Container(
     child: Container(
       child: reusableText("Settings"),
     ),
    ),
  );
}

Widget settingsButton(BuildContext context, void Function()? func){
  return GestureDetector(
    onTap: (){
      showDialog(context: context, builder: (BuildContext context){
        return  AlertDialog(
          title: const Text("Confirm logout"),
          content: const Text("Confirm logout"),
          actions: [
            TextButton(
                onPressed: ()=>Navigator.of(context).pop(),
                child: const Text("Cancel")
            ),
            TextButton(
                onPressed: func,
                child: const Text("Confirm")
            ),
          ],
        );
      });
    },
    child: Container(
      height: 100.w,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                  "assets/icons/Logout.png"
              )
          )
      ),

    ),
  );
}