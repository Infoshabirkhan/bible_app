import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controllers/Cubits/authentication_cubit/authentication_cubit.dart';


class LogoutAlertDialog extends StatefulWidget {

  const LogoutAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutAlertDialog> createState() => _LogoutAlertDialogState();
}

class _LogoutAlertDialogState extends State<LogoutAlertDialog> {
  bool showLoading = false;

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
                          'Confirmation!!!',
                          style: GoogleFonts.raleway(
                            fontSize: 24.sp,
                            color: const Color(0xff2D2D2D),
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
                        'Are you sure to logout. You will have to login again?',
                        style: GoogleFonts.raleway(
                            fontSize: 16.sp, color: const Color(0xff2D2D2D)),
                      ),
                    ),
                  ),
                  Expanded(
                    child:  Row(
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
                                  borderRadius:
                                  BorderRadius.circular(4.sp),
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

                                context.read<AuthenticationCubit>().signOut(context);

                              },
                              child: Container(
                                height: 45.sp,
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius:
                                    BorderRadius.circular(4.sp)),
                                child: Center(
                                  child: showLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : Text(
                                    'Yes, Logout',
                                    style: GoogleFonts.mulish(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight.bold),
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