import 'package:bible_app/Views/Widgets/password_fields.dart';
import 'package:bible_app/Views/authentication_screen/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controllers/Cubits/authentication_cubit/authentication_cubit.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  bool showLoading = false;
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationDeletionError) {
            Fluttertoast.showToast(
                msg: state.err,
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_LONG);

          }
          if (state is AuthenticationDeleted) {
            Fluttertoast.showToast(
                msg: "Account deleted successfully",
                backgroundColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                textColor: Colors.black);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
              left: 17.sp,
              right: 22.sp,
            ),
            width: 368.sp,
            height: 350.sp,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            child: Text(
                              'Confirmation!!!',
                              style: GoogleFonts.raleway(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Are you sure to delete your account. This action cannot be undone and will permanently delete all information related to your account.',
                            style: GoogleFonts.raleway(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.sp,
                      ),
                      PasswordFields(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Your Password',
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 45.sp,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.sp),
                                      color: const Color(0xffE3E1E8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No, cancel',
                                        style: GoogleFonts.mulish(
                                            color: const Color(0xff8D86A2),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.sp,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () async {
                                    context
                                        .read<AuthenticationCubit>()
                                        .deleteAccount(passwordController.text);
                                  },
                                  child: Container(
                                    height: 45.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(4.sp)),
                                    child: Center(
                                      child: (state is AuthenticationDeleting)
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Yes, Delete',
                                              style: GoogleFonts.mulish(
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onSubmit;

  const MyAlertDialog({
    Key? key,
    required this.onSubmit,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  var showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(
          left: 17.sp,
          right: 22.sp,
        ),
        width: 368.sp,
        height: 191.sp,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          widget.title,
                          style: GoogleFonts.raleway(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.content,
                        style: GoogleFonts.raleway(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 45.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.sp),
                                  color: const Color(0xffE3E1E8),
                                ),
                                child: Center(
                                  child: Text(
                                    'No, cancel',
                                    style: GoogleFonts.mulish(
                                        color: const Color(0xff8D86A2),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.sp,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () async {
                                showLoading = true;
                                setState(() {});

                                widget.onSubmit();
                              },
                              child: Container(
                                height: 45.sp,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4.sp)),
                                child: Center(
                                  child: showLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Confirm',
                                          style: GoogleFonts.mulish(
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
