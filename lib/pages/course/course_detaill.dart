import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:course_app/pages/course/widgets/course_detail_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {

  late var id;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as Map;
    print(id.values.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                      child: Column(
                        children: [

                        ],
                      ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
