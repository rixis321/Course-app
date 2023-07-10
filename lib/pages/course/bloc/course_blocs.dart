import 'package:course_app/pages/course/bloc/course_events.dart';
import 'package:course_app/pages/course/bloc/course_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvents, CourseStates>{
  CourseBloc():super(const CourseStates()){
    on<TriggerCourse>(_triggerCourse);
  }

  void _triggerCourse(TriggerCourse event, Emitter<CourseStates> emit){
      emit(state.copyWith(courseItem: event.courseItem));
  }

}