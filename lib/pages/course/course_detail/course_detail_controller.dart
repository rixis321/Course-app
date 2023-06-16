import 'package:course_app/common/apis/course_api.dart';
import 'package:course_app/common/entities/course.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:course_app/pages/course/course_detail/bloc/course_detail_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}