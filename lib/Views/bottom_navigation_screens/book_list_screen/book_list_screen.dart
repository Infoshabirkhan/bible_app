import 'package:bible_app/Controllers/Cubits/bible_books_cubit/bible_books_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:bible_app/Views/Widgets/my_banner_ad_widget.dart';
import 'package:bible_app/Views/Widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/Cubits/bottom_navigaiton_cubit.dart';
import '../../../Models/advertisement_id.dart';
import '../../../Models/models/task_model.dart';
import 'books_card.dart';

class BookListScreen extends StatefulWidget {
  final PageController pageController;
  const BookListScreen({Key? key,required this.pageController,}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {

  // final BannerAd myBanner = BannerAd(
  //   adUnitId: AdvertisementID.bannerAndroidId,
  //   size: AdSize.banner,
  //   request: AdRequest(),
  //   listener: BannerAdListener(),
  // );

  @override
  void initState() {
    // myBanner.load();

    context.read<BibleBooksCubit>().getBooks();
    context.read<BibleTaskCubit>().getTaskInfo();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        widget.pageController.jumpToPage(0);
        context.read<BottomNavigationCubit>().getNext(index: 0);
        return false;

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Traditional'),
        ),

        body:      BlocListener<BibleTaskCubit, BibleTaskState>(
          listener: (context, state) {

      if(state is BibleTaskAddingEntry ){
      ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Loading')));
      } if(state is BibleTaskDataAdded ){
      context.read<BibleTaskCubit>().getTaskInfo();
      }
      // TODO: implement listener
      },
        child: Column(
          children: [
            Expanded(

              child: BlocBuilder<BibleTaskCubit, BibleTaskState>(
                builder: (context, state) {
                  if(state is BibleTaskLoaded){
                    return Column(
                      // primary: false,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [


                                Spacer(),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    children: [
                                    state.model[0].totalChapters == 0 ? SizedBox():  Expanded(child:
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: FittedBox(
                                          child: Text('Books', style: GoogleFonts.poppins(

                                          ),),
                                        ),
                                      ),),



                                      Expanded(child: Align(
                                        alignment:    state.model[0].totalChapters == 0 ? Alignment.centerLeft: Alignment.center,


                                        child: FittedBox(
                                          child: Text('Chapters',style: GoogleFonts.poppins(


                                          ),),
                                        ),
                                      ),),

                                      const Spacer()



                                    ],
                                  ),),



                              ],
                            ),
                          ),
                        ),


                        Expanded(
                          flex: 9,
                          child: ListView.builder(

                              padding: EdgeInsets.symmetric(horizontal: 5.sp,),
                              itemCount: state.model.length,
                              itemBuilder: (context, index) {
                                var data =  state.model[index];
                                  return BookCard(data: data,);
                              }),
                        )
                      ],
                    );

                  }else if(state is BibleTaskNoInternet){
                    return NoInternetWidget(onRetry: (){
                      context.read<BibleTaskCubit>().getTaskInfo();
                    });
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),
            const MyBannerAdWidget()  ,      ],
        ),
      )
        // body:BookList()
      ),
    );
  }
}



