import 'package:course_app/common/routes/names.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/application/application_page.dart';
import 'package:course_app/pages/application/bloc/app_blocs.dart';
import 'package:course_app/pages/course/bloc/course_blocs.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:course_app/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:course_app/pages/course/lesson/lesson_detail.dart';
import 'package:course_app/pages/course/paywebview/bloc/payview_blocs.dart';
import 'package:course_app/pages/course/paywebview/paywebview.dart';
import 'package:course_app/pages/home/bloc/home_page_blocs.dart';
import 'package:course_app/pages/home/home_page.dart';
import 'package:course_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:course_app/pages/profile/settings/settings_page.dart';
import 'package:course_app/pages/register/bloc/register_blocs.dart';
import 'package:course_app/pages/register/register.dart';
import 'package:course_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:course_app/pages/sign_in/sign_in.dart';
import 'package:course_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:course_app/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/course/course_detaill.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(
            create: (_) => WelcomeBloc(),
          )),
      PageEntity(
          route: AppRoutes.SIGN_IN,
          page: const SignIn(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(
            create: (_) => RegisterBlocs(),
          )),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const ApplicationPage(),
         bloc: BlocProvider(create: (_)=> AppBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(create: (_)=> HomePageBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const SettingsPage(),
          bloc: BlocProvider(create: (_)=> SettingsBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.COURSE_DETAIL,
          page: const CourseDetail(),
          bloc: BlocProvider(create: (_)=> CourseDetailBloc(),)
      ),
      PageEntity(
          route: AppRoutes.LESSON_DETAIL,
          page: const LessonDetail(),
          bloc: BlocProvider(create: (_)=> LessonBlocs(),)
      ),
      PageEntity(
          route: AppRoutes.PAY_WEB_VIEW,
          page: const PayWebView(),
          bloc: BlocProvider(create: (_)=> PayWebViewBlocs(),)
      ),
    ];
  }

  //returning all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  // module that covers entire screen when user click navigation object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      //checking for route name matching when navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if(result.first.route== AppRoutes.INITIAL && deviceFirstOpen){
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if(isLoggedIn){
            return MaterialPageRoute(builder: (_)=> const ApplicationPage(),settings: settings);
          }
          return MaterialPageRoute(builder: (_)=> const SignIn(),settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    //print("invalid route name ${settings.name}");
    return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
  }
}

// unifying BlocProvider and routes and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
