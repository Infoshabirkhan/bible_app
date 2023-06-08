import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Models/Repo/profile_repo.dart';
import '../../../Widgets/my_text_field.dart';

class EditProfileContent extends StatefulWidget {
  final String name;
  final String address;
  final String profileUrl;

  const EditProfileContent({
    Key? key,
    required this.profileUrl,
    required this.name,
    required this.address,
  }) : super(key: key);

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.name;
    addressController.text = widget.address;

    // TODO: implement initState
    super.initState();
  }

  File? image;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      children: [
        SizedBox(
          height: 20.sp,
        ),

        Center(
          child: Container(
            width: 90.sp,
            height: 90.sp,
            decoration: BoxDecoration(
                // color: Colors.red,

                ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 1.sp,
                  right: 1.sp,
                  top: 0,
                  left: 2.sp,
                  child: Container(
                    padding: EdgeInsets.all(2.sp),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),

                    child: ClipOval(
                      child: image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )
                          : widget.profileUrl == ''
                              ? Image.asset(
                                  'assets/images/profile_placeholder.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.profileUrl,
                                  fit: BoxFit.cover,
                                ),
                    ),
                    // child: image != null
                    //
                    //
                    //     ? ClipOval(
                    //         child: Image.file(
                    //         image!,
                    //         fit: BoxFit.cover,
                    //       ))
                    //     : widget.profileUrl == ''
                    //         ? Image.asset(
                    //             'assets/images/profile_placeholder.png')
                    //         : Image.network(widget.profileUrl)
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                        onTap: () async {
                          final _picker = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (_picker != null) {
                            image = File(_picker.path);
                            setState(() {});
                          } else {}
                        },
                        child: Icon(CupertinoIcons.camera)))
              ],
            ),
          ),
        ),
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

        SizedBox(
          height: 20.sp,
        ),

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

        SizedBox(
          height: 20.sp,
        ),

        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ElevatedButton(
                onPressed: () async {
                  isLoading = true;

                  setState(() {});

                  FocusScope.of(context).unfocus();
                  await ProfileRepo.updateProfileInfo(
                      image: image,
                      address: addressController.text.trim(),
                      name: nameController.text.trim(),
                      url: widget.profileUrl);


                  Fluttertoast.showToast(msg: 'Updated Successfully',backgroundColor: Colors.green);
                  isLoading = false;

                  setState(() {});
                },
                child: Text('Save'),
              ),

        //FirebaseFirestore.instance
        //                     .collection('Users')
        //                     .doc(FirebaseAuth.instance.currentUser!.uid)
        //                     .snapshots()
      ],
    );
  }
}
