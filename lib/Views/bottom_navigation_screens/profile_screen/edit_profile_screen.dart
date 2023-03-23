import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            nameController.text = snapshot.data!['user_name'];
            addressController.text = snapshot.data!['address'];
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              children: [
                Text(
                  'Your name',
                  style: GoogleFonts.raleway(),
                ),
                SizedBox(
                  height: 4.sp,
                ),
                MyTextField(
                  controller: nameController,
                hintText: 'Your name',
                ),


                SizedBox(height: 20.sp,),



                Text(
                  'Address',
                  style: GoogleFonts.raleway(),
                ),
                SizedBox(
                  height: 4.sp,
                ),
                MyTextField(
                  controller: addressController,
                  hintText: 'Your address',
                ),



                SizedBox(height: 20.sp,),




                ElevatedButton(onPressed: () async {

                  ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Please wait...')));
              var ref =     FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid);


           await    ref.update({
                'address': addressController.text,
                "user_name" : nameController.text
              });


                  ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Updated Sucessfully')));


                }, child: Text('Save'),),

                //FirebaseFirestore.instance
                //                     .collection('Users')
                //                     .doc(FirebaseAuth.instance.currentUser!.uid)
                //                     .snapshots()
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
