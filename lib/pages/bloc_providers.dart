import 'package:course_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:course_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_blocks.dart';

class AppBlocProviders{
  static get allBlocProviders=>[
    BlocProvider(lazy: false, create: (context) => WelcomeBloc(),),
    BlocProvider(lazy: false, create: (context) => AppBlocs()),
    BlocProvider(create: (context) => SignInBloc())
  ];
}