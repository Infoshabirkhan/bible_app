import 'package:bible_app/Controllers/Cubits/bottom_navigaiton_cubit.dart';
import 'package:bible_app/Controllers/Cubits/default_book_cubit/default_book_cubit.dart';
import 'package:bible_app/Views/bottom_navigation_screens/profile_screen/profile_screen.dart';
import 'package:bible_app/Views/bottom_navigation_screens/progress_report_screen/progress_report_screen.dart';
import 'package:bible_app/Views/bottom_navigation_screens/sort_order_screen/sort_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'all_books_screen/all_books_screen.dart';
import 'book_list_screen/book_list_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    context.read<DefaultBookCubit>().getBook();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        height: 70.sp,
        child: Row(
          children: [
            BottomNavItems(
              title: 'Home',
              icon: Icons.home,
              currentIndex: 0,
              pageController: pageController,
            ),
            BottomNavItems(
              title: 'Books',
              icon: CupertinoIcons.book,
              currentIndex: 2,
              pageController: pageController,
            ),
            BottomNavItems(
              title: 'Sorted',
              icon: Icons.sort,
              currentIndex: 3,
              pageController: pageController,
            ),
            BottomNavItems(
              title: 'Profile',
              icon: Icons.person,
              currentIndex: 4,
              pageController: pageController,
            ),
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children:  [
          AllBooksScreen(pageController: pageController,),
          ProgressReportScreen(pageController: pageController,),
          BookListScreen(pageController: pageController,),
          SortedOrderScreen(pageController: pageController,),
          ProfileScreen(pageController: pageController,),
        ],
      ),
    );
  }
}

class BottomNavItems extends StatelessWidget {
  final PageController pageController;
  final IconData icon;
  final String title;
  final int currentIndex;

  const BottomNavItems({
    Key? key,
    required this.icon,
    required this.title,
    required this.currentIndex,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              pageController.jumpToPage(currentIndex);
              context
                  .read<BottomNavigationCubit>()
                  .getNext(index: currentIndex);
            },
            child: Column(
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    color: state == currentIndex ? Colors.red : Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: state == currentIndex ? Colors.red : Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
