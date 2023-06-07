import 'package:course_app/common/values/colors.dart';
import 'package:course_app/pages/application/widgets/application_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: buildPage(_index),
          bottomNavigationBar: Container(
            width: 375.w,
            height: 58.h,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.h),
                topRight: Radius.circular(20.h)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                )
              ]
            ),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (value) {
                setState(() {
                  _index = value;
                });
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: AppColors.primaryElement,
              unselectedItemColor: AppColors.primaryFourElementText,
              items: [
                BottomNavigationBarItem(
                  label: "home",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset("assets/icons/home.png"),
                  ),
                  activeIcon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/home.png",
                      color: AppColors.primaryElement,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "search",
                  icon: SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: Image.asset("assets/icons/search.png"),
                  ),
                  activeIcon: SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: Image.asset(
                      "assets/icons/search.png",
                      color: AppColors.primaryElement,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "course",
                  icon: SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: Image.asset("assets/icons/play-circle1.png"),
                  ),
                  activeIcon: SizedBox(
                    width: 18.w,
                    height: 18.h,
                    child: Image.asset(
                      "assets/icons/play-circle1.png",
                      color: AppColors.primaryElement,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "chat",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset("assets/icons/message-circle.png"),
                  ),
                  activeIcon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/message-circle.png",
                      color: AppColors.primaryElement,
                    ),
                  ),),
                BottomNavigationBarItem(
                  label: "profile",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset("assets/icons/person2.png"),
                  ),
                  activeIcon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/person2.png",
                      color: AppColors.primaryElement,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
