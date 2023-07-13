import 'package:course_app/common/entities/entities.dart';
import 'package:course_app/common/values/colors.dart';
import 'package:course_app/common/widgets/base_text_widget.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
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
                    child: Column(
                      children: [
                        //video preview
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
                              print('----------video snapshot is ${snapshot.connectionState}------------');
                            //check if the connection is mde to the certain video on server
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
                        ),
                        //video buttons
                        Container(
                          margin: EdgeInsets.only(top:15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //left button
                              GestureDetector(
                                onTap: (){
                                  videoIndex = videoIndex-1;
                                  if(videoIndex<0){
                                    videoIndex=0;
                                    toastInfo(msg: "This is the first video");
                                    return;
                                  }else{
                                    var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                                    _lessonControler.playVideo(videoItem.url!);
                                  }
                                },
                                child: Container(
                                  width: 24.w,
                                  height: 24.w,
                                  margin: EdgeInsets.only(right: 15.w),
                                  child: Image.asset("assets/icons/rewind-left(1).png"),
                                ),
                              ),
                              //play and pause button
                              GestureDetector(
                                onTap: (){
                                  //if its already playing
                                  if(state.isPlay){
                                    _lessonControler.videoPlayerController?.pause();
                                    context.read<LessonBlocs>().add(const TriggerPlay(false));
                                  }else{
                                    _lessonControler.videoPlayerController?.play();
                                    context.read<LessonBlocs>().add(const TriggerPlay(true));
                                  }
                                },
                                child: state.isPlay?Container(
                                  width: 24.w,
                                  height: 24.w,
                                  child: Image.asset("assets/icons/pause.png"),
                                ):Container(
                                  width: 24.w,
                                  height: 24.w,
                                  child: Image.asset("assets/icons/play-circle.png"),
                                )
                              ),
                              //right videos
                              GestureDetector(
                                onTap: (){
                                  videoIndex = videoIndex+1;
                                  if(videoIndex>=state.lessonVideoItem.length){
                                    //need to reduce, otherwise overflow
                                    videoIndex=videoIndex-1;
                                    toastInfo(msg: "No videos in the play list");
                                    return;
                                  }else{
                                    var videoItem = state.lessonVideoItem.elementAt(videoIndex);
                                    _lessonControler.playVideo(videoItem.url!);
                                  }
                                },
                                child: Container(
                                  width: 24.w,
                                  height: 24.w,
                                  margin: EdgeInsets.only(right: 15.w),
                                  child: Image.asset("assets/icons/rewind-right.png"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 25.w,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index){
                          return buildLessonItems(context, index, state.lessonVideoItem[index]);
                        },
                      childCount: state.lessonVideoItem.length
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

Widget buildLessonItems(BuildContext context, int index, LessonVideoItem item){
  return Container(
    width: 325.w,
    height: 80.h,
    margin: EdgeInsets.only(
      bottom: 20.h
    ),
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      color: Color.fromRGBO(255, 255, 255, 1),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0,1)
        )
      ]
    ),
    child: InkWell(
      onTap: (){

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.w),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage("${item.thumbnail}")
                    )
                ),
              ),
              Container(
                width: 210.h,
                height: 60.h,
                margin: EdgeInsets.only(left: 6.sp),
                child: reusableText(
                    "${item.name}",
                  fontSize: 13.sp
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: reusableText("play", fontSize: 13.sp),
              )
            ],
          )
        ],

      ),
    ),
  );
}