import 'package:course_app/common/entities/user.dart';
import 'package:course_app/global.dart';
import 'package:flutter/cupertino.dart';

class HomeController{
  final BuildContext context;
  HomeController({required this.context});

  UserItem? userProfile = Global.storageService.getUserProfile();

  void init(){
    print("home controller init method");
  }
}