import 'package:course_app/pages/course/paywebview/bloc/payview_events.dart';
import 'package:course_app/pages/course/paywebview/bloc/payview_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayWebViewBlocs extends Bloc<PayWebViewEvents,PayWebViewStates>{
  PayWebViewBlocs():super(const PayWebViewStates()){
    on<TriggerWebView>(_triggerWebView);
  }

  void _triggerWebView(TriggerWebView event, Emitter<PayWebViewStates> emit){
    emit(state.copyWith(url:event.url));
  }
}