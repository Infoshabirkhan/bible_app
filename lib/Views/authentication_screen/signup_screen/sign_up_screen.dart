import 'package:bible_app/Controllers/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:bible_app/Views/authentication_screen/login_screen/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/my_text_field.dart';
import '../../Widgets/password_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


 bool isValidate(){
   if(nameController.text.isEmpty){

     ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Name is Required')));

     return false;
   }else if(emailController.text.isEmpty){
     ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Email is Required')));
     return false;
   }else if(passwordController.text.isEmpty){
     ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Password is Required')));
     return false;
   }else if (confirmPasswordController.text.isEmpty) {
     ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Confirm password is Required')));
     return false;
   }else{
     return true;
   }
 }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async{

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return LoginScreen();
        }));
      return true;
        },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<AuthenticationCubit,AuthenticationState>(
          listener: (context, state) {
            if(state is AuthenticationLoading){
              showDialog(context: (context), builder: (context){
                return
                  Dialog(
                    child: Container(
                    height: 60.sp,
                    child:  Center(child: CircularProgressIndicator(),),
                ),
                  );
              });
            }else {
              Navigator.of(context).pop();
            }
            // TODO: implement listener
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            children: [
              Text('Sign Up', style: GoogleFonts.poppins(

                  fontSize: 25.sp
              ),),
              SizedBox(height: 4.sp,),
              Text('Please Provide the Information to sign up',
                style: GoogleFonts.poppins(

                ),)
              ,
              SizedBox(height: 15.sp,),

              Text('Name', style: GoogleFonts.poppins(),),
              MyTextField(

                hintText: 'Your name',
                controller: nameController,
              ),


              SizedBox(height: 25.sp,),

              Text('Email', style: GoogleFonts.poppins(),),
              MyTextField(

                hintText: 'Your email',
                controller: emailController,
              ),

              SizedBox(height: 25.sp,),

              Text('Password', style: GoogleFonts.poppins(),),
              PasswordFields(

                hintText: 'At least six Digit password',
                controller: passwordController,
              ),

              SizedBox(height: 25.sp,),

              Text('Confirm Password', style: GoogleFonts.poppins(),),
              PasswordFields(

                hintText: 'Confirm password',
                controller: confirmPasswordController,
              ),


              SizedBox(height: 30.sp,),

              Container(
                  height: 45.sp,
                  child: ElevatedButton(onPressed: () {

                  if(isValidate()){
                    if(passwordController.text != confirmPasswordController.text){
                      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Please enter the same password')));

                    }else{
                      context.read<AuthenticationCubit>().signUp(
                          userName: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()
                      );
                    }
                  }

                  }, child: Text('Sign Up'))),



              SizedBox(height: 20.sp,),
              Center(
                child: RichText(text: TextSpan(
                  text: 'Already have an account?'

                      ,
                  children: [
                    TextSpan(
                      text: ' Login',
                        style: TextStyle(
                            color: Colors.red
                        ),


                        recognizer: TapGestureRecognizer()..onTap =(){

                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){

                          return LoginScreen();
                        }));

                    }
                    )
                  ]
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}


