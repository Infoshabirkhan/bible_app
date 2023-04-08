import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:bible_app/Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/models/chapter_model.dart';
import 'package:bible_app/Views/Widgets/my_banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


class ProgressReportScreen extends StatefulWidget {
  const ProgressReportScreen({Key? key}) : super(key: key);

  @override
  State<ProgressReportScreen> createState() => _ProgressReportScreenState();
}

class _ProgressReportScreenState extends State<ProgressReportScreen> {


  @override
  void initState() {
    context.read<BibleTaskCubit>().getTaskInfo();

    context.read<ChapterCubit>().getChapter();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: const Text('Your Progress'),
      ),
      body: BlocListener<ChapterCubit, ChapterState>(
        listener: (context, state) {
          if(state is ChapterNoInternet){
            Fluttertoast.showToast(msg: 'No Internet connection', backgroundColor: Colors.red);
          }
          // TODO: implement listener
        },
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Container(

                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      border: Border.all(color: Colors.grey)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: ListView(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Text('Books Completed of 66', style: GoogleFonts.poppins(

                        fontSize: 20.sp,

                      ),),

                      BlocBuilder<BibleTaskCubit, BibleTaskState>(
                        builder: (context, state) {
                          if (state is BibleTaskLoaded) {
                            return Text('${BibleTaskRepo.completedTask.length}',
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontSize: 30.sp
                              ),);
                          } else {
                            return const ProgressShimmer();
                          }
                        },
                      ),


                      SizedBox(height: 10.sp,),


                      Text('Books Completed %', style: GoogleFonts.poppins(

                        fontSize: 20.sp,

                      ),),
                      BlocBuilder<BibleTaskCubit, BibleTaskState>(
                        builder: (context, state) {
                          if (state is BibleTaskLoaded) {
                            return Text(((BibleTaskRepo.completedTask.length /
                                state.model.length) * 100).toStringAsFixed(2),
                              style: GoogleFonts.poppins(

                                  color: Colors.green,
                                  fontSize: 30.sp
                              ),);
                          } else {
                            return const ProgressShimmer();
                          }
                        },
                      ),

                      SizedBox(height: 20.sp,),
                      Text('Chapters Completed of 1189',
                        style: GoogleFonts.poppins(

                          fontSize: 20.sp,

                        ),),


                      BlocBuilder<ChapterCubit, ChapterState>(
                        builder: (context, state) {
                          if (state is ChapterLoaded) {
                            return Text('${ChapterModel.model.chapterLength}',
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontSize: 30.sp
                              ),);
                          } else {
                            return const ProgressShimmer();
                          }
                        },
                      ),


                      SizedBox(height: 20.sp,),
                      Text('Chapters Completed %', style: GoogleFonts.poppins(

                        fontSize: 20.sp,

                      ),),


                      BlocBuilder<ChapterCubit, ChapterState>(
                        builder: (context, state) {
                          if (state is ChapterLoaded) {
                            return Text(((ChapterModel.model.chapterLength /
                                1189) * 100).toStringAsFixed(2),
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontSize: 30.sp
                              ),);
                          } else {
                            return const ProgressShimmer();
                          }
                        },
                      ),
                      SizedBox(height: 20.sp,)


                    ],
                  ),
                ),
              ),),

            const MyBannerAdWidget(),

          ],
        ),
      ),
    );
  }
}


class ProgressShimmer extends StatelessWidget {
  const ProgressShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: Colors.grey,
      highlightColor: Colors.white,


      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(

          margin: EdgeInsets.only(top: 15.sp),
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(10.sp)
          ),
          width: 0.5.sw,
          height: 15.sp,

        ),
      ),

    );
  }
}
