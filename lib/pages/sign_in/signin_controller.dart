import 'package:course_app/common/widgets/flutter_toast.dart';
import 'package:course_app/pages/sign_in/bloc/signin_blocs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            print("user exist");
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
}
