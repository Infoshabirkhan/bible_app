import 'package:bible_app/Controllers/Cubits/bottom_navigaiton_cubit.dart';
import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controllers/Cubits/add_new_book_cubit/book_list_cubit.dart';
import '../../Models/Repo/add_new_book_repo.dart';
import '../../Models/Repo/user_book_repo.dart';
import 'add_new_book.dart';

class BookNameScreen extends StatefulWidget {
 final  TextEditingController books ;
 final  TextEditingController chapters ;
  final PageController pageController;
  const BookNameScreen({Key? key,required this.books, required this.chapters,required this.pageController}) : super(key: key);

  @override
  State<BookNameScreen> createState() => _BookNameScreenState();
}

class _BookNameScreenState extends State<BookNameScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController bookController = TextEditingController();
  TextEditingController chapters = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        children: [



          SizedBox(
            height: 40.sp,
          ),

         Text("Please Provide the following information",style: GoogleFonts.cairo(

           fontSize: 16.sp
          ),),
          SizedBox(
            height: 20.sp,
          ),
          Text('Book name',style: GoogleFonts.cairo(),),
          SizedBox(height: 6,),

          MyTextField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Book name is required';
                }else{
                  return null;
                }
              },
              controller: bookController,
              hintText: 'Enter book name'),
          SizedBox(
            height: 25.sp,
          ),
          Text('Number of Chapters',style:GoogleFonts.cairo(),),
          SizedBox(height: 6,),
          MyTextField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Chapters is required';
                }else{
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: chapters,
              hintText: 'How many chapters in your book'),
          SizedBox(
            height: 10.sp,
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //
          //     if(formKey.currentState!.validate()){
          //       AddNewBookRepo.book['book_name'] =
          //           bookController.text.trim();
          //       var chapter = int.parse(chapters.text);
          //       AddNewBookRepo.book['total_chapters'] = chapter;
          //
          //       List<TextEditingController>  list = [];
          //       Navigator.of(context).pop();
          //       for(var i = 0; i<int
          //           .parse(chapters.text); i++ ){
          //         list.add(TextEditingController());
          //       }
          //       context.read<BookListCubit>().getLength(index: list,);
          //       Navigator.of(context)
          //           .push(MaterialPageRoute(builder: (context) {
          //         return AddNewBook(books: bookController.text,
          //           chapters: int.parse(chapters.text),);
          //       }));
          //
          //     }
          //   },
          //   child: Text('Submit'),
          // ),

          SizedBox(height: 30.sp,),

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () async {

                if(formKey.currentState!.validate()){
                  // AddNewBookRepo.book['book_name'] =
                  //     bookController.text.trim();
                  //
                  UserBookRepo.mainBook =
                      bookController.text.trim();
                  print('============ ${UserBookRepo.mainBook}');
                  var chapter = int.parse(chapters.text);
                  AddNewBookRepo.book['total_chapters'] = chapter;

                  List<TextEditingController>  list = [];
                  for(var i = 0; i<int
                      .parse(chapters.text); i++ ){
                    list.add(TextEditingController());
                  }
                  context.read<BookListCubit>().getLength(index: list,);

                  FocusScope.of(context).unfocus();
                  widget.books.text = bookController.text;
                  widget.chapters.text = chapters.text;


                  context.read<BottomNavigationCubit>().getNext(index: 1);
                  widget.pageController.jumpToPage(1);


                }
              },

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.sp , horizontal: 2.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.sp),
                  color: Colors.grey.withOpacity(0.06)
                ),
                width: 0.44.sw,
                child: Row(
                  children: [
                    Expanded(child: Center(
                      child: FittedBox(

                        child: Text('Continue',style: GoogleFonts.cairo(

                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),),
                    Expanded(child: Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.6),
                        shape: BoxShape.circle
                      ),
                      child: Center(child: Icon(Icons.arrow_forward_ios),),
                    ))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}
