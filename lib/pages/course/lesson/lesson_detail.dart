import 'package:course_app/common/entities/entities.dart';
import 'package:course_app/common/values/colors.dart';
import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:course_app/pages/course/lesson/bloc/lesson_states.dart';
import 'package:course_app/pages/course/lesson/lesson_controller.dart';
import 'package:course_app/pages/course/lesson/widgets/lesson_detail_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'bloc/lesson_blocs.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({Key? key}) : super(key: key);

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  late LessonControler _lessonController;
  int videoIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _lessonController = LessonControler(context: context);
    context.read<LessonBlocs>().add(const TriggerUrlItem(null));
    context.read<LessonBlocs>().add(const TriggerVideoIndex(0));
    _lessonController.init();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _lessonController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBlocs, LessonStates>(builder: (context, state) {
      print('my future is ${state.initializeVideoPlayerFuture}');
      return SafeArea(
        child: Container(
            color: Colors.grey,
            child: Scaffold(
                backgroundColor: Colors.grey,
                appBar: buildAppBar("Lesson detail"),
                body: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 25.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            //video preview
                            videoPlayer(state, _lessonController),
                            //video buttons
                            videoControls(state, _lessonController, context)
                          ],
                        ),
                      ),
                    ),
                    videoList(state, _lessonController),
                  ],
                ))),
      );
    });
  }

}
