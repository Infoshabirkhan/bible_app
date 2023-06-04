import 'package:bible_app/Controllers/Cubits/bible_books_cubit/bible_books_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controllers/Cubits/bottom_navigaiton_cubit.dart';
import '../../Widgets/my_banner_ad_widget.dart';
import '../../Widgets/no_internet_widget.dart';
import '../book_list_screen/books_card.dart';

class SortedOrderScreen extends StatefulWidget {
  final PageController pageController;
  const SortedOrderScreen({Key? key, required this.pageController}) : super(key: key);

  @override
  State<SortedOrderScreen> createState() => _SortedOrderScreenState();
}

class _SortedOrderScreenState extends State<SortedOrderScreen> {
  @override
  void initState() {
    context.read<BibleBooksCubit>().getBooks();
    context.read<BibleTaskCubit>().getTaskInfo(isSortAscending: true);
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
            title: const Text('Shortest to Longest'),
          ),
          body: BlocListener<BibleTaskCubit, BibleTaskState>(
            listener: (context, state) {
              if (state is BibleTaskAddingEntry) {
                ScaffoldMessenger.of(context)
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Loading'),
                    ),
                  );
              }
              if (state is BibleTaskDataAdded) {
                context.read<BibleTaskCubit>().getTaskInfo(isSortAscending: true);
              }
              // TODO: implement listener
            },
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<BibleTaskCubit, BibleTaskState>(
                    builder: (context, state) {
                      if (state is BibleTaskLoaded) {
                        return Column(
                          // primary: false,
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: FittedBox(
                                              child: Text(
                                                'Books',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: FittedBox(
                                              child: Text(
                                                'Chapter',
                                                style: GoogleFonts.poppins(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Spacer()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.sp,
                                ),
                                itemCount: state.model.length,
                                itemBuilder: (context, index) {
                                  var data = state.model[index];
                                  return BookCard(
                                    data: data,
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                      else if(state is BibleTaskNoInternet){
                        return NoInternetWidget(onRetry: (){
                          context.read<BibleTaskCubit>().getTaskInfo(isSortAscending: true);
                        });
                      }else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                const MyBannerAdWidget(),
              ],
            ),
          )
          // body:BookList()
          ),
    );
  }
}
