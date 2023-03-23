import 'package:bible_app/Controllers/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:bible_app/Views/authentication_screen/signup_screen/sign_up_screen.dart';
import 'package:bible_app/Views/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/my_text_field.dart';
import '../../Widgets/password_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthenticationCubit,AuthenticationState>(
        listener: (context, state) {
          if(state is AuthenticationLoading){
            showDialog(context: (context), builder: (context){
              return
                Dialog(
                  child: Container(
                    child:  ListView(
                      shrinkWrap: true,
                      children: [
                        Center(child: Text('Please wait..',style: GoogleFonts.raleway(
                          fontSize: 18.sp
                        ),),),
                        SizedBox(height: 15.sp,),
                        Center(child: CircularProgressIndicator(),),

                        SizedBox(height: 15.sp,),

                      ],
                    ),
                  ),
                );
            });

          }
            if(state is AuthenticationLoaded){

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                return BottomNavigationScreen();
              }), (route) => false);
              // Navigator.of(context).push(MaterialPageRoute(builder: (context){
              //   return BottomNavigationScreen();
              // }));
            }
            if(state is AuthenticationError){
              Navigator.of(context).pop();
            }
            // Navigator.of(context).pop();

          // TODO: implement listener
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          children: [



            Text('Welcome Back!',style: GoogleFonts.poppins(

              fontSize: 25.sp
            ),),
            SizedBox(height: 15.sp,),
            Text('Log In', style: GoogleFonts.poppins(

                fontSize: 25.sp
            ),),
            SizedBox(height: 4.sp,),
            Text('Please Provide your credential to login',
              style: GoogleFonts.poppins(

              ),),


            SizedBox(height: 25.sp,),

            Text('Email', style: GoogleFonts.poppins(),),
            MyTextField(

              hintText: 'Your email',
              controller: emailController,
            ),

            SizedBox(height: 25.sp,),

            Text('Password', style: GoogleFonts.poppins(),),
            PasswordFields(

              hintText: 'Your Password',
              controller: passwordController,
            ),




            SizedBox(height: 30.sp,),

            Container(
                height: 45.sp,
                child: ElevatedButton(onPressed: () {

                  if(passwordController.text.isEmpty || emailController.text.isEmpty){

                    ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Email and password is required'),),);
                    // Fluttertoast.showToast(msg: 'Please enter the same password');
                  }else{
                    context.read<AuthenticationCubit>().login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()
                    );
                  }

                }, child: Text('Log in'))),



            SizedBox(height: 20.sp,),
            Center(
              child: RichText(text: TextSpan(
                  text: 'Don\'t have an account? '

                  ,
                  children: [
                    TextSpan(
                        text: 'Create New Account',
                        style: TextStyle(
                          color: Colors.red
                        ),
                        recognizer: TapGestureRecognizer()..onTap =(){

                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){

                            return SignUpScreen();
                          }));

                        }
                    )
                  ]
              ),),
            )

          ],
        ),
      ),
    );
  }
}


