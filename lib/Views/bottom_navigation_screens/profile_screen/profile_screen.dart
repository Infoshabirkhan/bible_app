import 'package:bible_app/Views/Widgets/delete_account_dialog.dart';
import 'package:bible_app/Views/Widgets/logout_alert_dialog.dart';
import 'package:bible_app/Views/Widgets/my_banner_ad_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_profile_screen/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 0.35.sh,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !snapshot.hasError) {
                          if (snapshot.data != null) {
                            var image = snapshot.data!['profile_image'];
                            var name = snapshot.data!['user_name'];

                            return Column(
                              children: [
                                Expanded(
                                    child: Center(
                                  child: Container(
                                    width: 120.sp,
                                    height: 120.sp,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.white)),
                                    child: ClipOval(
                                      clipBehavior: Clip.hardEdge,
                                      child: image == ''
                                          ? Image.asset(
                                              'assets/images/profile_placeholder.png',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              snapshot.data!['profile_image'],
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                )),
                                Expanded(
                                    // flex: 2,
                                    child: Text(
                                  name,
                                  style: GoogleFonts.raleway(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                )),
                              ],
                            );
                          } else {
                            return const Center(child: Text('not found'));
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                      }),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const EditProfileScreen();
                        },
                      ),
                    );
                  },
                  leading: const Icon(Icons.person),
                  title: const Text('Edit Profile'),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const DeleteAccountDialog();
                        });
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('Delete Account'),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LogoutAlertDialog();
                        });
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                ),
                SizedBox(
                  height: 50.sp,
                ),
              ],
            ),
          ),
          const MyBannerAdWidget(),
        ],
      ),
    );
  }
}
