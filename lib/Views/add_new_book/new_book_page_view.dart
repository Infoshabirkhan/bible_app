import 'package:bible_app/Controllers/Cubits/bottom_navigaiton_cubit.dart';
import 'package:bible_app/Views/add_new_book/book_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/Repo/add_new_book_repo.dart';
import 'add_new_book.dart';

class NewBookPageView extends StatefulWidget {
  const NewBookPageView({Key? key}) : super(key: key);

  @override
  State<NewBookPageView> createState() => _NewBookPageViewState();
}

class _NewBookPageViewState extends State<NewBookPageView> {
  TextEditingController books = TextEditingController();
  TextEditingController chapters = TextEditingController(text: '0');

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new book'),
      ),
      body: Column(
        children: [
          Container(
            height: 25.sp,
            child: BlocBuilder<BottomNavigationCubit, int>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state == 0
                                ? Colors.blue.withOpacity(0.6)
                                : Colors.grey.withOpacity(0.6)),
                        child: Center(
                          child: Text(
                            '1',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state == 1
                                ? Colors.blue.withOpacity(0.6)
                                : Colors.grey.withOpacity(0.6)),
                        child: Center(
                          child: Text(
                            '2',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              BookNameScreen(
                chapters: chapters,
                books: books,
                pageController: pageController,
              ),
              AddNewBook(
                pageController: pageController,
                chapters: int.parse(chapters.text),
                books: books.text,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
