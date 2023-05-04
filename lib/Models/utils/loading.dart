

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

showLoading(context, message){
  return showDialog(
      barrierDismissible: false,

      context: (context),
      builder: (context) {
        return Dialog(
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(fontSize: 18.sp),
                  ),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 15.sp,
                ),
              ],
            ),
          ),
        );
      });
}