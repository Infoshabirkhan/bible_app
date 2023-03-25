import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindAccountScreen extends StatelessWidget {
  // final String email;
  const FindAccountScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find your Account'),


      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        children: [

          SizedBox(height: 20.sp,),


        ],
      ),
    );
  }
}
