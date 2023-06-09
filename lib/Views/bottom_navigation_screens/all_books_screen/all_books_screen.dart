import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/add_new_book_cubit.dart';
import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/book_list_cubit.dart';
import 'package:bible_app/Controllers/Cubits/bottom_navigaiton_cubit.dart';
import 'package:bible_app/Controllers/Cubits/default_book_cubit/default_book_cubit.dart';
import 'package:bible_app/Models/Repo/add_new_book_repo.dart';
import 'package:bible_app/Models/models/default_book_model.dart';
import 'package:bible_app/Views/Widgets/my_banner_ad_widget.dart';
import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:bible_app/Views/add_new_book/new_book_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/Repo/chapter_task_repo.dart';

class AllBooksScreen extends StatefulWidget {
  final PageController pageController;

  const AllBooksScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  @override
  void initState() {
    context.read<BottomNavigationCubit>().getNext(index: 0);
    context.read<AddNewBookCubit>().getBook();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Confirmation!!'),
                content: Text('Are you sure want to exit the app'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book list'),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 50.sp),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NewBookPageView();
              }));
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AddBookDailog();
              //     });
            },
            label: Text('Add Book'),
            icon: Icon(Icons.add),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: BlocListener<AddNewBookCubit, AddNewBookState>(
              listener: (context, state) {
                if (state is AddNewBookDone) {
                  context.read<AddNewBookCubit>().getBook();
                }
                // TODO: implement listener
              },
              child: BlocBuilder<AddNewBookCubit, AddNewBookState>(
                builder: (context, state) {
                  if (state is AddNewBookLoaded) {
                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      children: [
                        SizedBox(
                          height: 20.sp,
                        ),
                        InkWell(
                          onTap: () {
                            ChapterTaskRepo.bookName = 'The Holy Quran';
                            ChapterTaskRepo.bookId = 'Quran';
                            widget.pageController.jumpToPage(1);
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10.sp),
                              decoration: BoxDecoration(
                                // color: Colors.black,
                                //    boxShadow: [
                                //
                                //  BoxShadow(color: Colors.grey.withAlpha(100),blurRadius: 5),
                                // ],
                                  border: Border.all(
                                      color: Colors.grey[700] ?? Colors.grey)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.sp, horizontal: 5.sp),
                              child:
                              BlocBuilder<DefaultBookCubit, DefaultBookModel?>(
                                builder: (context, defaultBook) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'The Holy Quran',
                                          style:
                                          GoogleFonts.raleway(fontSize: 20.sp),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Align(
                                      //     alignment: Alignment.centerRight,
                                      //     child: Text(
                                      //       defaultBook!.bookId == 'bible'
                                      //           ? 'Default'
                                      //           : '',
                                      //       style: TextStyle(color: Colors.red),
                                      //     ),
                                      //   ),
                                      // ),

                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: defaultBook!.bookId == 'Quran'
                                              ? Container(
                                            height: 25.sp,
                                            child: Image.asset(
                                              'assets/images/check.png',
                                              color: Colors.red,
                                            ),
                                          )
                                              : SizedBox(),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            ChapterTaskRepo.bookName = 'The Holy Bible';
                            ChapterTaskRepo.bookId = 'bible';
                            widget.pageController.jumpToPage(1);
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10.sp),
                              decoration: BoxDecoration(
                                // color: Colors.black,
                                //    boxShadow: [
                                //
                                //  BoxShadow(color: Colors.grey.withAlpha(100),blurRadius: 5),
                                // ],
                                  border: Border.all(
                                      color: Colors.grey[700] ?? Colors.grey)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.sp, horizontal: 5.sp),
                              child:
                              BlocBuilder<DefaultBookCubit, DefaultBookModel?>(
                                builder: (context, defaultBook) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'The Holy Bible',
                                          style:
                                          GoogleFonts.raleway(fontSize: 20.sp),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Align(
                                      //     alignment: Alignment.centerRight,
                                      //     child: Text(
                                      //       defaultBook!.bookId == 'bible'
                                      //           ? 'Default'
                                      //           : '',
                                      //       style: TextStyle(color: Colors.red),
                                      //     ),
                                      //   ),
                                      // ),

                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: defaultBook!.bookId == 'bible'
                                              ? Container(
                                            height: 25.sp,
                                            child: Image.asset(
                                              'assets/images/check.png',
                                              color: Colors.red,
                                            ),
                                          )
                                              : SizedBox(),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.list.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Visibility(
                                visible: state.list[index].documentId != 'bible' &&
                                    state.list[index].documentId != 'Quran',
                                child: InkWell(
                                  onTap: () {
                                    ChapterTaskRepo.bookId =
                                        state.list[index].documentId;
                                    ChapterTaskRepo.bookName =
                                        state.list[index].bookName;

                                    widget.pageController.jumpToPage(1);

                                    // print("===================${state.list[index].documentId} ");
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 10.sp),
                                      decoration: BoxDecoration(
                                        // color: Colors.black,
                                        //    boxShadow: [
                                        //
                                        //  BoxShadow(color: Colors.grey.withAlpha(100),blurRadius: 5),
                                        // ],
                                          border: Border.all(
                                              color:
                                              Colors.grey[700] ?? Colors.grey)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.sp, horizontal: 5.sp),
                                      child: BlocBuilder<DefaultBookCubit,
                                          DefaultBookModel?>(
                                        builder: (context, defaultBook) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  state.list[index].bookName,
                                                  style: GoogleFonts.raleway(
                                                      fontSize: 20.sp),
                                                ),
                                              ),
                                              // Expanded(
                                              //     child: Align(
                                              //         alignment: Alignment.centerRight,
                                              //         child: Text(
                                              //           defaultBook!.bookId ==
                                              //                   state.list[index]
                                              //                       .documentId
                                              //               ? 'Default'
                                              //               : '',
                                              //           style: TextStyle(
                                              //               color: Colors.red),
                                              //         )))

                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: defaultBook!.bookId ==
                                                      state.list[index]
                                                          .documentId
                                                      ? Container(
                                                    height: 25.sp,
                                                    child: Image.asset(
                                                      'assets/images/check.png',
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                      : SizedBox(),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      )),
                                ),
                              );
                            }),
                      ],
                    );
                  } else if (state is AddNewBookLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AddNewBookError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),),
            MyBannerAdWidget(),
          ],
        ),
      ),
    );
  }
}

class AddBookDailog extends StatefulWidget {
  const AddBookDailog({Key? key}) : super(key: key);

  @override
  State<AddBookDailog> createState() => _AddBookDailogState();
}

class _AddBookDailogState extends State<AddBookDailog> {
  TextEditingController bookController = TextEditingController();
  TextEditingController chapters = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          children: [
            SizedBox(
              height: 10.sp,
            ),
            Stack(
              children: [
                Center(
                  child: Text(
                    'Add Book',
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          margin: EdgeInsets.all(5.sp),
                          child: Icon(Icons.close))),
                ),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text('Book name'),
            SizedBox(
              height: 6,
            ),
            MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Book name is required';
                  } else {
                    return null;
                  }
                },
                controller: bookController,
                hintText: 'Enter book name'),
            SizedBox(
              height: 10.sp,
            ),
            Text('Number of Chapters'),
            SizedBox(
              height: 6,
            ),
            MyTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chapters is required';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                controller: chapters,
                hintText: 'How many chapters in your book'),
            SizedBox(
              height: 10.sp,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  AddNewBookRepo.book['book_name'] = bookController.text.trim();
                  var chapter = int.parse(chapters.text);
                  AddNewBookRepo.book['total_chapters'] = chapter;

                  List<TextEditingController> list = [];
                  Navigator.of(context).pop();
                  for (var i = 0; i < int.parse(chapters.text); i++) {
                    list.add(TextEditingController());
                  }
                  context.read<BookListCubit>().getLength(
                        index: list,
                      );
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return AddNewBook(books: bookController.text,
                  //     chapters: int.parse(chapters.text),);
                  // }));
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(
              height: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
