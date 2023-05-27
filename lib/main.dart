import 'package:course_app/app_blocks.dart';
import 'package:course_app/app_events.dart';
import 'package:course_app/app_states.dart';
import 'package:course_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:course_app/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(create: (context) => AppBlocs())
      ],
      child: ScreenUtilInit(
        builder: (context, child) =>MaterialApp(
          home: const Welcome(),
          routes: {
            "myHomePage":(context) =>const MyHomePage(),
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: BlocBuilder<AppBlocs, AppStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  "${BlocProvider.of<AppBlocs>(context).state.counter}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: "heroTag1",
              onPressed: () =>
                  BlocProvider.of<AppBlocs>(context).add(Increment()),
              tooltip: 'Increment',
              child: const Icon(Icons.add)),
          FloatingActionButton(
              heroTag: "heroTag2",
              onPressed: () =>
                  BlocProvider.of<AppBlocs>(context).add(Decrement()),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
