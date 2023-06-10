import 'dart:convert';

import 'package:course_app/common/apis/user_api.dart';
import 'package:course_app/common/entities/user.dart';
import 'package:course_app/common/values/constant.dart';
import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/global.dart';
import 'package:course_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// diwevig538@vaband.com
// Qwerty123

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          toastInfo(msg: "Your need to fill email address");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "Your need to fill password");
          return;
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailAddress, password: password);
          if (credential.user == null) {
            toastInfo(msg: "You do not exist");
            return;
          }
          if (!credential.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
            return;
          }

          var user = credential.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;
            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            // 1 means email login
            loginRequestEntity.type = 1;
            
            asyncPostAllData(loginRequestEntity);
            

          } else {
            toastInfo(msg: "You are not a user of this app");
            return;
          }
        } on FirebaseAuthException catch(e){
          if(e.code == 'user-not-found'){
            print('No user found for that email');
            toastInfo(msg: "No user found for that email");
            return;
          }else if (e.code == 'wrong-password'){
            print('Wrong password provided for that user');
            toastInfo(msg: "No password provided for that user");
            return;
          }else if(e.code == 'invalid-email'){
            print("Your email format is wrong");
            toastInfo(msg: "Your email address format is wrong");
            return;
          }
        }
      }
    } catch (e) {}
  }


  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    var result = await UserAPI.login(params: loginRequestEntity);
   if(result.code == 200){
     try{
       Global.storageService.setString(AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
       Global.storageService.setString(AppConstants.STORAGE_USER_TOKEN_KEY,result.data!.access_token!);
       EasyLoading.dismiss();
       Navigator.of(context).pushNamedAndRemoveUntil("/application", (route) => false);

     }catch(e){
       print("saving local storage error ${e.toString()}");
     }
   }else{
     EasyLoading.dismiss();
     toastInfo(msg: "Unknown error");
   }
  }
}
