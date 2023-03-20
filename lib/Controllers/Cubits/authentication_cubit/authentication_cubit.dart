import 'package:bible_app/Models/Repo/authentication_repo.dart';
import 'package:bible_app/Views/authentication_screen/login_screen/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());


  signUp({required String email, required String password, required String userName})async {

    emit(AuthenticationLoading());
    var response = await AuthenticationRepo.signUp(email: email, password: password, userName: userName);

    if(response == true){


      emit(AuthenticationLoaded());

      // Fluttertoast.showToast(msg: 'Account Created Sucessfully');
    }else{
      emit(AuthenticationError());
    }

  }


  login({required String email, required String password}) async {
    emit(AuthenticationLoading());

    var result = await AuthenticationRepo.login(email: email, password: password);

    if(result == true){
      emit(AuthenticationLoaded());

    }else{
      emit(AuthenticationError());
    }

  }

  signOut(context)async{

   await FirebaseAuth.instance.signOut();

   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){


     return LoginScreen();
   }));

  }

}
