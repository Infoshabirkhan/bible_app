import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/advertisement_id.dart';

class MyBannerAdWidget extends StatefulWidget {
  const MyBannerAdWidget({Key? key}) : super(key: key);

  @override
  State<MyBannerAdWidget> createState() => _MyBannerAdWidgetState();
}

class _MyBannerAdWidgetState extends State<MyBannerAdWidget> {
  // final BannerAd myBanner = BannerAd(
  //   adUnitId: Platform.isAndroid
  //       ? AdvertisementID.bannerAndroidId
  //       : AdvertisementID.bannerIosId,
  //   size: AdSize.banner,
  //   request: const AdRequest(),
  //   listener: const BannerAdListener(),
  // );

  @override
  void initState() {
    // myBanner.load();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // myBanner.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return Align(
    //   alignment: Alignment.bottomCenter,
    //   child: Container(
    //     margin: EdgeInsets.only(top: 15.sp),
    //     width: myBanner.size.width.toDouble(),
    //     height: myBanner.size.height.toDouble(),
    //     child: AdWidget(
    //       ad: myBanner,
    //     ),
    //   ),
    // );
  }
}
