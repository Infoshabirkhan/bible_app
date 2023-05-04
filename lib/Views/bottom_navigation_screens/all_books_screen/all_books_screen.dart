import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/add_new_book_cubit.dart';
import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/book_list_cubit.dart';
import 'package:bible_app/Controllers/Cubits/default_book_cubit/default_book_cubit.dart';
import 'package:bible_app/Models/Repo/add_new_book_repo.dart';
import 'package:bible_app/Models/models/default_book_model.dart';
import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/Repo/chapter_task_repo.dart';
import 'add_new_book.dart';

class AllBooksScreen extends StatefulWidget {
  final PageController pageController;

  const AllBooksScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  TextEditingController bookController = TextEditingController();
  TextEditingController chapters = TextEditingController();

  @override
  void initState() {
    context.read<AddNewBookCubit>().getBook();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book list'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    children: [
                      SizedBox(height: 20.sp,),

                      Text('Book name'),
                      MyTextField(
                          controller: bookController,
                          hintText: 'Enter book name'),

                      SizedBox(height: 10.sp,),
                      Text('Chapters'),
                      MyTextField(
                          keyboardType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: chapters,
                          hintText: 'Enter book name'),

                      SizedBox(height: 10.sp,),
                      ElevatedButton(
                        onPressed: () async {
                          AddNewBookRepo.book['book_name'] =
                              bookController.text.trim();
                          var chapter = int.parse(chapters.text);
                          AddNewBookRepo.book['total_chapters'] =
                              chapter;

                          for (var i = 0; i < chapter; i++) {
                            AddNewBookRepo.readChapters.add({
                              "status": false,
                              "notes": [],
                            });
                          }
                          AddNewBookRepo.book['read_chapters'] =
                              AddNewBookRepo.readChapters;


                          await context.read<AddNewBookCubit>().addBook();

                          Navigator.of(context).pop();
                          // context.read<BookListCubit>().getLength(index: int
                          //     .parse(chapters.text),);
                          // Navigator.of(context).pop();
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return AddNewBook(books: bookController.text,
                          //     chapters: int.parse(chapters.text),);
                          // }));
                        },
                        child: BlocBuilder<AddNewBookCubit, AddNewBookState>(
                          builder: (context, state) {
                            if (state is AddNewBookLoading) {
                              return Center(
                                child: CircularProgressIndicator(),);
                            } else {
                              return Text('Submit');
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10.sp,),

                    ],
                  ),
                );
              });
        },
        label: Text('Add Book'),
        icon: Icon(Icons.add),
      ),
      body: BlocListener<AddNewBookCubit, AddNewBookState>(
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
                        child: BlocBuilder<DefaultBookCubit, DefaultBookModel?>(
  builder: (context, defaultBook) {
    return Row(
                          children: [
                            Expanded(
                              child: Text(
                                'The Holy Bible',
                                style: GoogleFonts.raleway(fontSize: 20.sp),
                              ),
                            ),
                            Expanded(child: Align(

                                alignment: Alignment.centerRight,

                                child: Text(defaultBook!.bookId == 'bible' ? 'Default':'',style: TextStyle(
                                  color: Colors.red
                                ),)))

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
                        return InkWell(
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
                                  border:
                                  Border.all(color: Colors.grey[700] ??
                                      Colors.grey)),
                              padding:
                              EdgeInsets.symmetric(
                                  vertical: 10.sp, horizontal: 5.sp),
                              child: BlocBuilder<DefaultBookCubit, DefaultBookModel?>(
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

                                      Expanded(child: Align(

                                          alignment: Alignment.centerRight,
                                          child: Text(defaultBook!.bookId == state.list[index].documentId ? 'Default':'',style: TextStyle(
                                            color: Colors.red
                                          ),)))
                                    ],
                                  );
                                },
                              )),
                        );
                      }),
                ],
              );
            } else if (state is AddNewBookLoading) {
              return Center(child: CircularProgressIndicator(),);
            } else if (state is AddNewBookError) {
              return Center(child: Text(state.error),);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
