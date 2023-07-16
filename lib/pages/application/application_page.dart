import 'package:course_app/common/values/colors.dart';
import 'package:course_app/pages/application/bloc/app_blocs.dart';
import 'package:course_app/pages/application/bloc/app_events.dart';
import 'package:course_app/pages/application/bloc/app_states.dart';
import 'package:course_app/pages/application/widgets/application_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBlocs,AppState>(builder: (context,state){
      return Container(
        color: Colors.grey,
        child: SafeArea(
          child: Scaffold(
            body: buildPage(state.index),
          ),
        ),
      );
    });
  }
}
