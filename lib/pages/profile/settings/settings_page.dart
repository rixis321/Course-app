import 'package:course_app/common/routes/routes.dart';
import 'package:course_app/common/values/constant.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/application/bloc/app_blocs.dart';
import 'package:course_app/pages/application/bloc/app_events.dart';
import 'package:course_app/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:course_app/pages/profile/settings/bloc/settings_states.dart';
import 'package:course_app/pages/profile/settings/widgets/settings_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void removeUserData(){
      context.read<AppBlocs>().add(const TriggerAppEvent(0));
      Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
      Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs,SettingStates>(
           builder: (context,state){
             return Container(
                child:  Column(
                  children: [
                      settingsButton(context, removeUserData),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
