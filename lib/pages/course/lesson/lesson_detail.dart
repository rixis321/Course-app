import 'package:course_app/common/values/colors.dart';
import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:course_app/pages/course/lesson/bloc/lesson_events.dart';
import 'package:course_app/pages/course/lesson/bloc/lesson_states.dart';
import 'package:course_app/pages/course/lesson/lesson_controller.dart';
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

  late LessonControler _lessonControler;
  int videoIndex = 0;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _lessonControler = LessonControler(context: context);
    context.read<LessonBlocs>().add(TriggerUrlItem(null));
    _lessonControler.init();
  }

  @override
  void dispose(){
    _lessonControler.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonBlocs, LessonStates>(builder: (context, state){
      return SafeArea(

        child: Container(
          color: Colors.white,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar("Lesson detail"),
            body: CustomScrollView(
              slivers: [
                SliverPadding(padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 25.w
                ),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 325.w,
                            height: 200.h,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/icons/video.png"
                                ),
                                fit: BoxFit.fitWidth
                              ),
                              borderRadius: BorderRadius.circular(20.h)
                            ),
                            child: FutureBuilder(
                              future: state.initializeVideoPlayerFuture,
                              builder: (context, snapshot){
                                if(snapshot.connectionState==ConnectionState.done){
                                  return _lessonControler.videoPlayerController==null?Container():AspectRatio(
                                    aspectRatio: _lessonControler.videoPlayerController!.value.aspectRatio,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        VideoPlayer(_lessonControler.videoPlayerController!),
                                        VideoProgressIndicator(_lessonControler.videoPlayerController!, allowScrubbing: true,
                                        colors: VideoProgressColors(playedColor: AppColors.primaryElement),)
                                      ],
                                    ),
                                  );
                                }else{
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      );
    });
  }
}
