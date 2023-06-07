import 'dart:io';

import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:bible_app/Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'package:bible_app/Controllers/Cubits/default_book_cubit/default_book_cubit.dart';
import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/Repo/chapter_task_repo.dart';
import 'package:bible_app/Models/models/chapter_model.dart';
import 'package:bible_app/Models/models/default_book_model.dart';
import 'package:bible_app/Models/shared_pref.dart';
import 'package:bible_app/Views/Widgets/my_banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProgressReportScreen extends StatefulWidget {
  final PageController pageController;

  const ProgressReportScreen({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<ProgressReportScreen> createState() => _ProgressReportScreenState();
}

class _ProgressReportScreenState extends State<ProgressReportScreen> {
  @override
  void initState() {
    // context.read<BibleTaskCubit>().getTaskInfo();

    context.read<ChapterCubit>().getChapter();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.pageController.jumpToPage(0);

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.pageController.jumpToPage(0);
            },
            icon: Icon(Icons.adaptive.arrow_back),
          ),
          centerTitle: true,
          title: const Text('Your Progress'),
        ),
        body: BlocListener<ChapterCubit, ChapterState>(
          listener: (context, state) {
            if (state is ChapterNoInternet) {
              Fluttertoast.showToast(
                  msg: 'No Internet connection', backgroundColor: Colors.red);
            }
            // TODO: implement listener
          },
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.sp, bottom: 20.sp),
                        child: Text(
                          ChapterTaskRepo.bookName,
                          style: GoogleFonts.raleway(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(color: Colors.grey)),
                        margin: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: ListView(
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            BlocBuilder<ChapterCubit, ChapterState>(
                              builder: (context, state) {
                                if (state is ChapterLoaded) {
                                  return Text(
                                    'Chapters Completed of ${ChapterModel.model.totalBooks}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                    ),
                                  );
                                } else {
                                  return const ProgressShimmer();
                                }
                              },
                            ),
                            BlocBuilder<ChapterCubit, ChapterState>(
                              builder: (context, state) {
                                if (state is ChapterLoaded) {
                                  return Text(
                                    '${ChapterModel.model.readBooks}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.green, fontSize: 30.sp),
                                  );
                                  // return Text('${BibleTaskRepo.completedTask.length}',
                                  //   style: GoogleFonts.poppins(
                                  //       color: Colors.green,
                                  //       fontSize: 30.sp
                                  //   ),);
                                } else {
                                  return const ProgressShimmer();
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              'Chapters Completed %',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                              ),
                            ),
                            BlocBuilder<ChapterCubit, ChapterState>(
                              builder: (context, state) {
                                if (state is ChapterLoaded) {
                                  // return Text(((BibleTaskRepo.completedTask.length /
                                  //     state.model.length) * 100).toStringAsFixed(2),
                                  //   style: GoogleFonts.poppins(
                                  //
                                  //       color: Colors.green,
                                  //       fontSize: 30.sp
                                  //   ),);
                                  return Text(
                                    '${((ChapterModel.model.readBooks /
                                                    ChapterModel.model.totalBooks) *
                                                100)
                                            .toStringAsFixed(2)}',
                                    // ((ChapterModel.model.readBooks /
                                    //             ChapterModel.model.totalBooks) *
                                    //         100)
                                    //     .toStringAsFixed(2),
                                    style: GoogleFonts.poppins(
                                        color: Colors.green, fontSize: 30.sp),
                                  );
                                } else {
                                  return const ProgressShimmer();
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                                 BlocBuilder<ChapterCubit, ChapterState>(
                              builder: (context, state) {
                                if (state is ChapterLoaded) {
                                  return ChapterModel.model.totalChapters == 0 ? SizedBox():   Text(
                                    'Sub Chapter Completed of ${ChapterModel.model.totalChapters}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                    ),
                                  );
                                } else {
                                  return ProgressShimmer();
                                }
                              },
                            ),
                                BlocBuilder<ChapterCubit, ChapterState>(
                              builder: (context, state) {
                                if (state is ChapterLoaded) {
                                  // return Text('${ChapterModel.model.chapterLength}',
                                  //   style: GoogleFonts.poppins(
                                  //       color: Colors.green,
                                  //       fontSize: 30.sp
                                  //   ),);
                                  return  ChapterModel.model.totalChapters == 0 ? SizedBox():Text(
                                    '${ChapterModel.model.completedChapters}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.green, fontSize: 30.sp),
                                  );
                                } else {
                                  return const ProgressShimmer();
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                        BlocBuilder<ChapterCubit, ChapterState>(
  builder: (context, state) {
    return  ChapterModel.model.totalChapters == 0 ? SizedBox(): Text(
                              'Sub Chapters Completed %',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                              ),
                            );
  },
),
                              BlocBuilder<ChapterCubit, ChapterState>(
                              builder: (context, state) {
                                if (state is ChapterLoaded) {
                                  return  ChapterModel.model.totalChapters == 0 ? SizedBox(): Text(
                                    ((ChapterModel.model.completedChapters /
                                        ChapterModel.model.totalChapters) *
                                            100)
                                        .toStringAsFixed(2),
                                    style: GoogleFonts.poppins(
                                        color: Colors.green, fontSize: 30.sp),
                                  );
                                } else {
                                  return const ProgressShimmer();
                                }
                              },
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                print('============${ChapterTaskRepo.bookId}');
                                await SharedPrefs.setDefaultBook(

                                  DefaultBookModel(
                                    bookId: ChapterTaskRepo.bookId,
                                    bookName: ChapterTaskRepo.bookName,
                                    isPreDefined:
                                        ChapterTaskRepo.isPredefinedBook,
                                    isList: ChapterTaskRepo.isList,
                                  ),
                                );
                                await context
                                    .read<DefaultBookCubit>()
                                    .getBook();

                                ScaffoldMessenger.of(context)
                                  ..showSnackBar(SnackBar(
                                    content: Text(
                                        '${ChapterTaskRepo.bookName} is set as default book'),
                                  ));
                              },
                              child: Text('Continue Reading?'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const MyBannerAdWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressShimmer extends StatelessWidget {
  const ProgressShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(top: 15.sp),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
          width: 0.5.sw,
          height: 15.sp,
        ),
      ),
    );
  }
}
