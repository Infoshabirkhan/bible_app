import 'package:bible_app/Models/Repo/authentication_repo.dart';
import 'package:bible_app/Models/utils/internet_connectivity.dart';
import 'package:bible_app/Views/authentication_screen/login_screen/login_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());


  signUp({required String email, required String password, required String userName})async {
    if(await InternetConnectivity.isNotConnected()){

      emit(AuthenticationNoInternet());
      return;
    }
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

    if(await InternetConnectivity.isNotConnected()){

      emit(AuthenticationNoInternet());
      return;
    }
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


   Navigator.of(context).pushAndRemoveUntil((MaterialPageRoute(builder: (context){

   return const LoginScreen();
   })), (route) => false);
   // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
   //
   //
   //   return LoginScreen();
   // }));

  }
  
  
  deleteAccount(String password)async{
    try{
      var user=FirebaseAuth.instance.currentUser;
      String id=user!.uid;
      emit(AuthenticationDeleting());
      var uc=await user!.reauthenticateWithCredential(EmailAuthProvider.credential(email: user.email!, password: password));
      if(uc.user!=null) {
        await uc.user!.delete();
        await FirebaseFirestore.instance.collection("Users").doc(id).delete();
        emit(AuthenticationDeleted());
      }
    } catch(e){
      if(e is FirebaseException){
        emit(AuthenticationDeletionError(err: e.message.toString()));
      }
      else if(e is FirebaseAuthException){
        emit(AuthenticationDeletionError(err: e.message.toString()));
      }
    }
  }

}
