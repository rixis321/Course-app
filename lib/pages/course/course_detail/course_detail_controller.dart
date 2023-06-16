import 'package:course_app/common/apis/course_api.dart';
import 'package:course_app/common/entities/course.dart';
import 'package:course_app/common/routes/names.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_detail_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CourseDetailController{
  final BuildContext context;

  CourseDetailController({required this.context});

  void init() async{
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAllData(args["id"]);
  }

  asyncLoadAllData(int? id) async{
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;

   var result = await CourseAPI.courseDetail(params: courseRequestEntity);
    if(result.code == 200){
      if(context.mounted){
        context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
      }else{
        print("---------------------context is not available-------------------");
      }


    }else{
      toastInfo(msg: "Something went wrong");
      print("-----------------------Error code ${result.code}-----------------------");
    }

  }

  Future<void> goBuy(int? id) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id =id;
    var result = await CourseAPI.coursePay(params: courseRequestEntity);

    EasyLoading.dismiss();
    if(result.code == 200){
      //cleaner format of url
      var url = Uri.decodeFull(result.data!);
      var res = await Navigator.of(context).pushNamed(AppRoutes.PAY_WEB_VIEW, arguments: {
        "url": url
      });
      if(res=="success"){
        toastInfo(msg: result.msg!);
      }
     // print("my returned stripe url is $url");
    }else{
      toastInfo(msg: result.msg!);
    }
  }
}