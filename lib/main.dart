import 'package:course_app/common/routes/routes.dart';
import 'package:course_app/pages/register/register.dart';
import 'package:course_app/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/values/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: AppColors.primaryText),
                  elevation: 0,
                  backgroundColor: Colors.white)),
          onGenerateRoute: AppPages.GenerateRouteSettings,
          routes: {
            "signIn": (context) => const SignIn(),
            "register": (context) => const Register()
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Demo Home Page"),
      ),
    );
  }
}
