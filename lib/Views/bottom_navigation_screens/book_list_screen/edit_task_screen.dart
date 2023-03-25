import 'dart:io';

import 'package:bible_app/Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'package:bible_app/Models/Repo/advertisement_repo.dart';
import 'package:bible_app/Models/Repo/bible_book_repo.dart';
import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Models/advertisement_id.dart';


class EditTaskScreen extends StatefulWidget {
  final TaskModel model;
  const EditTaskScreen({Key? key,required this.model}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  final BannerAd myBanner = BannerAd(
    adUnitId: AdvertisementID.bannerAndroidId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    myBanner.load();
    AdvertisementRepo.showInterstitialAd();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.model.bookName, style: GoogleFonts.raleway(),),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: BibleTaskRepo.taskRef.doc(widget.model.documentId).snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData && !snapshot.hasError){
                  var data = snapshot.data;
                return  GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      itemCount: widget.model.totalChapters,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100 ), itemBuilder: (context, index){


                    return Row(
                      children: [
                        Expanded(child: Checkbox(value: data!['read_chapters'][index], onChanged: (bool? value) async {





                          if(value !=null){

                            var list = data!['read_chapters'];

                            //print(list);
                            list[index] = value;

                          //  print('============== after list $list');
                           await BibleTaskRepo.taskRef.doc(widget.model.documentId).update(
                                {
                                  "read_chapters" : list
                                });
                           context.read<ChapterCubit>().setChapter(value: value);



                          }
                          setState(() {

                          });

                        },),),

                        Expanded(child: Text("${index +1}"))
                      ],
                    );
                  });
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return Center(child: Text('something went wrong'),);
                }
              },
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
      )
    );
  }
}
