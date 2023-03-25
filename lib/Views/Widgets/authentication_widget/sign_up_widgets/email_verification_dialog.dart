import 'package:bible_app/Views/authentication_screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationDialog extends StatelessWidget {
  final TextEditingController email;
  const EmailVerificationDialog({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              child: Text('Please verify you email',style: GoogleFonts.raleway(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,

              )),
            ),
          ),
          SizedBox(height: 20.sp,),



          Center(
            child: RichText(text: TextSpan(
              text: 'We send email verification link to '
              ,  style: GoogleFonts.raleway(
                fontSize: 16

            ),

            children: [
              TextSpan(
                text: email.text,
                style: GoogleFonts.raleway(
                    fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
              TextSpan(
                text: ' also check spam',
                style: GoogleFonts.raleway(
                    fontSize: 16,
                ),
              ),
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
  }
}
