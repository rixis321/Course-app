import 'package:course_app/common/entities/user.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/home/bloc/home_page_blocs.dart';
import 'package:course_app/pages/home/bloc/home_page_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/apis/course_api.dart';

class HomeController{
  late BuildContext context;
  UserItem? get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton = HomeController._internal();

  HomeController._internal();

  //factory contructor for signleton
  factory HomeController({required BuildContext context}){
    _singleton.context = context;
    return _singleton;
  }


  Future<void> init() async {

    if(Global.storageService.getUserToken().isNotEmpty){
      var result = await CourseAPI.courseList();
      print("the result is ${result.data![0]}");
      if(result.code==200){
        context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
        return;
      }else{
        print(result.code);
        return;
      }
    }else{
      print("User has already logged out");
    }
    return;
  }
}