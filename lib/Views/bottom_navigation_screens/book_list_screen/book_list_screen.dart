import 'package:bible_app/Controllers/Cubits/bible_books_cubit/bible_books_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Models/advertisement_id.dart';
import '../../../Models/models/task_model.dart';
import 'books_card.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {

  final BannerAd myBanner = BannerAd(
    adUnitId: AdvertisementID.bannerAndroidId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    myBanner.load();

    context.read<BibleBooksCubit>().getBooks();
    context.read<BibleTaskCubit>().getTaskInfo();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    Expanded(child:
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FittedBox(
                                        child: Text('Books', style: GoogleFonts.poppins(

                                        ),),
                                      ),
                                    ),),



                                    Expanded(child: Center(
                                      child: FittedBox(
                                        child: Text('Chapter',style: GoogleFonts.poppins(


                                        ),),
                                      ),
                                    ),),

                                    Spacer()
                                    // Expanded(child: Center(
                                    //
                                    //   child: FittedBox(
                                    //     child: Text('Related Notes',style: GoogleFonts.poppins(
                                    //
                                    //
                                    //     ),),
                                    //   ),
                                    // ),),


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

                }else{
                  return Center(child: CircularProgressIndicator(),);
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
      ),
    )
      // body:BookList()
    );
  }
}



//      body: BlocBuilder<BibleBooksCubit, BibleBooksState>(
//         builder: (context, state) {
//
//           if(state is BibleBooksLoaded){
//
//           return BookList(list: state.model,);
//           }else  {
//             return Center(child: CircularProgressIndicator(),);
//           }
//         },
//       ),