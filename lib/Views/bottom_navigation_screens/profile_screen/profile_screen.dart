import 'package:bible_app/Views/Widgets/logout_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Controllers/Cubits/authentication_cubit/authentication_cubit.dart';
import '../../../Models/advertisement_id.dart';
import 'edit_profile_screen/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final BannerAd myBanner = BannerAd(
    adUnitId: AdvertisementID.bannerAndroidId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  @override
  void initState() {
    myBanner.load();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4hzxgryUCe9sRZwO0k_RO67kGvybOICgSSA&usqp=CAU';
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
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
                                            width: 2,
                                            color: Colors.white
                                          )
                                        ),
                                        child: ClipOval(
                                          clipBehavior: Clip.hardEdge,
                                          child: image == '' ?Image.asset(
                                            'assets/images/profile_placeholder.png',
                                            fit: BoxFit.cover,
                                          ) :Image.network(
                                            snapshot.data!['profile_image'] ,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    // flex: 2,
                                    child: Text(name,style: GoogleFonts.raleway(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600
                                    ),)),
                              ],
                            );
                          } else {
                            return Center(child: Text('not found'));
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // return Shimmer.fromColors(
                          //   baseColor: Colors.grey,
                          //   highlightColor: Colors.white,
                          //   child: Container(
                          //     child: Column(
                          //       children: [
                          //         Expanded(
                          //           child: Align(
                          //             alignment: Alignment.centerLeft,
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   shape: BoxShape.circle),
                          //               height: 50.sp,
                          //               width: 50.sp,
                          //             ),
                          //           ),
                          //         ),
                          //         Expanded(
                          //           flex: 2,
                          //           child: Align(
                          //             alignment: Alignment.centerLeft,
                          //             child: Container(
                          //               height: 15.sp,
                          //               width: 0.4.sw,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );

                          return Center(child: CircularProgressIndicator(),);
                        } else {
                          return Center(child: Text('Something went wrong'));
                        }
                      }),
                ),
                SizedBox(height: 10.sp,),
                ListTile(
                  onTap: () {

                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return EditProfileScreen();
                    }));
                    // ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Not Created yet')));
                    // // Fluttertoast.showToast(msg: 'Not created yet',backgroundColor: Colors.red);
                  },
                  leading: Icon(Icons.person),
                  title: Text('Edit Profile'),
                ),


                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return LogoutAlertDialog();
                        });
                  },
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),

                SizedBox(height: 50.sp,),


              ],
            ),
          ),
          SizedBox(height: 15.sp,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(

              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
              child: AdWidget(ad: myBanner,),
            ),),

        ],
      ),
    );
  }
}
