import 'package:bible_app/Views/authentication_screen/forgot_password/find_account_screen.dart';
import 'package:bible_app/Views/bottom_navigation_screens/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/my_text_field.dart';
import '../login_screen/login_screen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),

      body: Form(

        key:  formKey,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          children: [
            SizedBox(height: 20.sp,),
            Text('Please Enter your email Address',style: GoogleFonts.raleway(
              fontSize: 20.sp
            ),),

            SizedBox(height: 20.sp,),

            Text('We will send the a password recovery instruction to your email',style: GoogleFonts.raleway(
                fontSize: 16.sp
            ),),

            SizedBox(height: 20.sp,),

            Text('Your email'),
            MyTextField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter your email';
                }else if(!value.contains('@')){
                  return 'Please enter a valid email';

                }else{
                  return null;
                }
              },
              controller: emailController, hintText: 'Enter your email',

            ),

            SizedBox(height: 20.sp,),

           isLoading  ? Center(child: CircularProgressIndicator(),): ElevatedButton(onPressed: () async {

              if(formKey.currentState!.validate()){

                try {
                  isLoading = true;
                  setState(() {

                  });


                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

                   showDialog(context: context, builder: (context){

                  return  Dialog(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      children: [

                        SizedBox(height: 20.sp,),
                        SizedBox(
                            height: 90.sp,
                            width: 90.sp,
                            child: Image.asset('assets/images/mail.png', color: Colors.red,)),
                        SizedBox(height: 20.sp,),
                        Center(
                          child: FittedBox(
                            child: Text('Email Send successfully',style: GoogleFonts.raleway(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,

                            )),
                          ),
                        ),
                        SizedBox(height: 20.sp,),



                        Center(
                          child: RichText(text: TextSpan(
                              text: 'We send password recovery instruction to your email '
                              ,  style: GoogleFonts.raleway(
                              fontSize: 16

                          ),

                              children: [
                                // TextSpan(
                                //   text: em,
                                //   style: GoogleFonts.raleway(
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w600
                                //   ),
                                // ),
                                // TextSpan(
                                //   text: ' also check spam',
                                //   style: GoogleFonts.raleway(
                                //     fontSize: 16,
                                //   ),
                                // ),
                              ]),),
                        ),

                        SizedBox(height: 20.sp,),

                        ElevatedButton(onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil((MaterialPageRoute(builder: (context){

                            return LoginScreen();
                          })), (route) => false);
                        }, child: Text("Submit"),),

                        SizedBox(height: 15.sp,),
                      ],
                    ),
                  );
                });


                } on FirebaseAuthException catch (e) {
                  print('====================exception ${e.code}');

                  ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Error : ${e.code}')));
                  // TODO
                }

                isLoading = false;
                setState(() {

                });



               // var ref = await FirebaseFirestore.instance.collection('Users').where("email" , isEqualTo: emailController.text.trim()).get();
               //
               //
               //
               // if(ref.docs.isNotEmpty){
               //   isLoading = false;
               //   setState(() {
               //
               //   });
               //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
               //     return FindAccountScreen();
               //   }));
               //
               //
               // }else{
               //   print('================ not found');
               //   ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('No account found with this email')));
               //   isLoading = false;
               //   setState(() {
               //
               //   });
               // }
               //

              }else{

              }

            }, child: Text('Submit'),),
          ],
        ),
      ),
    );
  }
}
