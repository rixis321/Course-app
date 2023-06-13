import 'package:course_app/common/entities/user.dart';
import 'package:course_app/global.dart';
import 'package:flutter/cupertino.dart';

import '../../common/apis/course_api.dart';

class HomeController{
  final BuildContext context;
  HomeController({required this.context});

  UserItem? userProfile = Global.storageService.getUserProfile();

  Future<void> init() async {

   var result = await CourseAPI.courseList();
   if(result.code==200){
     print("perfect");
     print(result.data![0].name);
   }else{
     print(result.code);
   }

  }
}