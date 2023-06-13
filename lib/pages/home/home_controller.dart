import 'package:course_app/common/entities/user.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/home/bloc/home_page_blocs.dart';
import 'package:course_app/pages/home/bloc/home_page_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/apis/course_api.dart';

class HomeController{
  final BuildContext context;
  HomeController({required this.context});

  UserItem? userProfile = Global.storageService.getUserProfile();

  Future<void> init() async {

   var result = await CourseAPI.courseList();
   if(result.code==200){
     context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
   }else{
     print(result.code);
   }

  }
}