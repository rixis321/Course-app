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
          print("email empty");
        }else{
          print("email is $emailAddress");
        }
        if (password.isEmpty) {
          print("password empty");
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailAddress, password: password);
          if (credential.user == null) {
            print("user does not exist");
          }
          if (!credential.user!.emailVerified) {
            print("not varied");
          }

          var user = credential.user;
          if (user != null) {
            print("user exist");
          } else {
            print("no user");
          }
        } on FirebaseAuthException catch(e){
          if(e.code == 'user-not-found'){
            print('No user found for that email');
          }else if (e.code == 'wrong-password'){
            print('Wrong password provided for that user');
          }else if(e.code == 'invalid-email'){
            print("Your email format is wrong");
          }
        }
      }
    } catch (e) {}
  }
}
