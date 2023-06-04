import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/add_new_book_cubit.dart';
import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/book_list_cubit.dart';
import 'package:bible_app/Models/Repo/add_new_book_repo.dart';
import 'package:bible_app/Models/Repo/user_book_repo.dart';
import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:bible_app/Views/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controllers/Cubits/bottom_navigaiton_cubit.dart';
import '../../Models/utils/loading.dart';

class AddNewBook extends StatefulWidget {
  final PageController pageController;
  final String books;
  final int chapters;

  const AddNewBook({Key? key, required this.pageController, required this.chapters, required this.books,})
      : super(key: key);

  @override
  State<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  // TextEditingController bookNameController = TextEditingController();
  // TextEditingController chapterController = TextEditingController();
  // TextEditingController b = TextEditingController();

  List<TextEditingController> chapterLength = [];
  List<TextEditingController> bookName = [];


  getController() {
    var list = context
        .read<BookListCubit>()
        .state;
    for (var i = 0; i < list.length; i++) {
      bookName.add(TextEditingController());
      chapterLength.add(TextEditingController(text: '0'));
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<BookListCubit, List<TextEditingController>>(
        builder: (context, list) {
          return Padding(

            padding: EdgeInsets.only(bottom: 45.sp),
            child: FloatingActionButton(
              onPressed: () {

                chapterLength.add(TextEditingController(text: '0'));
                bookName.add(TextEditingController());

                list.add(TextEditingController());
                context.read<BookListCubit>().getLength(index: list);
                Fluttertoast.showToast(msg: 'New book added', backgroundColor: Colors.green);

              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
      body: BlocListener<AddNewBookCubit, AddNewBookState>(
        listener: (context, state) async {
          if (state is AddNewBookDone) {
            context.read<AddNewBookCubit>().getBook();
            context.read<BottomNavigationCubit>().getNext(index: 0);

            Fluttertoast.showToast(msg: 'Book added Successfully', backgroundColor: Colors.green);
            Navigator.of(context).pop();
           await Future.delayed(Duration(milliseconds: 500));

          }
          if (state is AddNewBookError) {
            Fluttertoast.showToast(msg: state.error);
          }if(state is AddNewBookLoading){
            // showDialog(
            //     barrierDismissible: false,
            //
            //     context: (context),
            //     builder: (context) {
            //       return Dialog(
            //         child: Container(
            //           child: ListView(
            //             shrinkWrap: true,
            //             children: [
            //               Center(
            //                 child: Text(
            //                   'Please wait..',
            //                   style: GoogleFonts.raleway(fontSize: 18.sp),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 15.sp,
            //               ),
            //               Center(
            //                 child: CircularProgressIndicator(),
            //               ),
            //               SizedBox(
            //                 height: 15.sp,
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     });
          }
          // TODO: implement listener
        },
        child: BlocBuilder<BookListCubit, List<TextEditingController>>(
          builder: (context, stateList) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 10.sp,),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 80.sp),

                        itemCount: stateList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.sp, horizontal: 8.sp),
                            margin: EdgeInsets.symmetric(
                                vertical: 10.sp, horizontal: 10.sp),
                            child: ListView(
                              shrinkWrap: true,
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              children: [


                                Row(
                                  children: [
                                    // Expanded(child: Text(' (${index + 1})'),),
                                    Expanded(child: index == 0
                                        ? SizedBox()
                                        : InkWell(

                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          bookName.removeAt(index);
                                          chapterLength.removeAt(index);
                                          context.read<BookListCubit>()
                                              .getLength(index: chapterLength);
                                          Fluttertoast.showToast(msg: 'Book removed', backgroundColor: Colors.green);

                                        },
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(Icons.delete,
                                              color: Colors.red,))))
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Expanded(child: Text(
                                //       'Chapter Name',),),
                                //     Expanded(
                                //       flex: 2,
                                //       child: MyTextField(
                                //
                                //
                                //         inputFormatter: [
                                //           // FilteringTextInputFormatter.digitsOnly
                                //         ],
                                //
                                //         validator: (value) {
                                //           if (value == null || value.isEmpty) {
                                //             return 'Please provide Chapter name';
                                //           } else {
                                //             return null;
                                //           }
                                //         },
                                //         controller: bookName[index],
                                //         hintText: 'Enter Chapter name',),),
                                //   ],
                                // ),

                                Text(
                                  'Enter Chapter No. ${index+1} name',),
                                SizedBox(height: 4.sp,),
                                MyTextField(


                                  inputFormatter: [
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide chapter name';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: bookName[index],
                                  hintText:   'Enter Chapter ${index+1} name',),
                                SizedBox(height: 20.sp,),
                                Row(
                                  children: [
                                    Expanded(child: Text(
                                      'Sub Chapters in Chapter No. ${index +1}',),),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(child: InkWell(


                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            onTap: (){
                                            var chapter =   int.parse(chapterLength[index].text);

                                            if(chapter != 0){
                                              --chapter;

                                              chapterLength[index].text = chapter.toString();
                                            }

                                            },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey.withOpacity(0.3)
                                                ),
                                                child: Center(child: Icon(Icons.remove)),
                                              )),),
                                          Expanded(child: MyTextField(

                                            enabled: false,
                                            textAlign: TextAlign.center,

                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white.withOpacity(0.5)
                                              ),
                                                borderRadius: BorderRadius.circular(6.sp)
                                            ),
                                            keyboardType: TextInputType.number,
                                            inputFormatter: [
                                              FilteringTextInputFormatter.digitsOnly
                                            ],

                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please provide number of sub chapters';
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: chapterLength[index],
                                            hintText: '',),),
                                          Expanded(child:  InkWell(


                                              highlightColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onTap: (){
                                                var chapter =   int.parse(chapterLength[index].text);

                                                  ++chapter;

                                                  chapterLength[index].text = chapter.toString();


                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue.withOpacity(0.3)
                                                ),
                                                child: Center(child: Icon(Icons.add)),
                                              ),),)
                                        ],
                                      ),),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),

                  Container(
                      margin: EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 10.sp),

                      width: 1.sw,
                      child: BlocBuilder<AddNewBookCubit, AddNewBookState>(
  builder: (context, state) {
  if(state is AddNewBookLoading){
    return Center(child: CircularProgressIndicator(),);
  }else{
    return ElevatedButton(onPressed: () async {
      FocusScope.of(context).unfocus();

      if (formKey.currentState!.validate()) {
        // AddNewBookRepo.book['book_name'] = widget.books;
        // AddNewBookRepo.book['total_chapters'] =
        //     widget.chapters;


        UserBookRepo.mainBook = widget.books;
        var readChapters = {
          "status": false,
          "notes": [],
        };
        var totalChapters = 0;

        for (var i = 0; i < stateList.length; i++) {
          UserBookRepo.listOfBooks.add({
            'id': '',
            "book_name": bookName[i].text,
            "read_chapters": [],
            "read_status": false,
            "total_chapters": int.parse(
                chapterLength[i].text),
          });
          totalChapters += int.parse(chapterLength[i].text);
        }


        UserBookRepo.numberOfChapters;
        for (var item in UserBookRepo.listOfBooks) {
          List<Map<String, dynamic>> readChapters = [];
          for (var i = 0; i < item['total_chapters']; i++) {
            readChapters.add({
              "status": false,
              "notes": [],
            });
          }
          item['read_chapters'] = readChapters;
        }
        print(UserBookRepo.listOfBooks);


        UserBookRepo.numberOfChapters = totalChapters;
        // for (var i = 0; i < widget.chapters; i++) {
        //   AddNewBookRepo.readChapters.add({
        //     "status": false,
        //     "notes": [],
        //   });
        // }
        // AddNewBookRepo.book['sub_headings'] =
        //     AddNewBookRepo.readChapters;
        context.read<AddNewBookCubit>().addBook();

      }
    }, child: Text('Submit')
    );
  }
  },
))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



//    return Scaffold(
//       floatingActionButton: BlocBuilder<BookListCubit, List<TextEditingController>>(
//         builder: (context, list) {
//           return Padding(
//
//             padding: EdgeInsets.only(bottom: 45.sp),
//             child: FloatingActionButton(
//               onPressed: () {
//
//                 chapterLength.add(TextEditingController());
//                 bookName.add(TextEditingController());
//
//                 list.add(TextEditingController());
//                 context.read<BookListCubit>().getLength(index: list);
//
//               },
//               child: Icon(Icons.add),
//             ),
//           );
//         },
//       ),
//       appBar: AppBar(title: Text('Add book'),),
//       body: BlocListener<AddNewBookCubit, AddNewBookState>(
//         listener: (context, state) {
//           if (state is AddNewBookDone) {
//             context.read<AddNewBookCubit>().getBook();
//
//             Fluttertoast.showToast(msg: 'Book added Successfully', backgroundColor: Colors.green);
//             Navigator.of(context).pop();
//           }
//           if (state is AddNewBookError) {
//             Fluttertoast.showToast(msg: state.error);
//           }
//           // TODO: implement listener
//         },
//         child: BlocBuilder<BookListCubit, List<TextEditingController>>(
//           builder: (context, stateList) {
//             return Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//
//                         itemCount: stateList.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey)
//                             ),
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10.sp, horizontal: 8.sp),
//                             margin: EdgeInsets.symmetric(
//                                 vertical: 10.sp, horizontal: 10.sp),
//                             child: ListView(
//                               shrinkWrap: true,
//                               primary: false,
//                               physics: NeverScrollableScrollPhysics(),
//                               children: [
//
//
//                                 Row(
//                                   children: [
//                                     Expanded(child: Text(' (${index + 1})'),),
//                                     Expanded(child: index == 0
//                                         ? SizedBox()
//                                         : InkWell(
//
//                                         hoverColor: Colors.transparent,
//                                         highlightColor: Colors.transparent,
//                                         splashColor: Colors.transparent,
//                                         onTap: () {
//                                           bookName.removeAt(index);
//                                           chapterLength.removeAt(index);
//                                           context.read<BookListCubit>()
//                                               .getLength(index: chapterLength);
//                                         },
//                                         child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Icon(Icons.delete,
//                                               color: Colors.red,))))
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(child: Text(
//                                       'Chapter Name',),),
//                                     Expanded(
//                                       flex: 2,
//                                       child: MyTextField(
//
//
//                                         inputFormatter: [
//                                           // FilteringTextInputFormatter.digitsOnly
//                                         ],
//
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please provide Chapter name';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: bookName[index],
//                                         hintText: 'Enter Chapter name',),),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(child: Text(
//                                       'Number of \nSub chapters',),),
//                                     Expanded(
//                                       flex: 2,
//                                       child: MyTextField(
//
//
//                                         keyboardType: TextInputType.number,
//                                         inputFormatter: [
//                                           FilteringTextInputFormatter.digitsOnly
//                                         ],
//
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Please provide number of sub chapters';
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                         controller: chapterLength[index],
//                                         hintText: 'Number of sub chapters',),),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           );
//                         }),
//                   ),
//
//                   Container(
//                       margin: EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 10.sp),
//
//                       width: 1.sw,
//                       child: ElevatedButton(onPressed: () async {
//                         if (formKey.currentState!.validate()) {
//                           // AddNewBookRepo.book['book_name'] = widget.books;
//                           // AddNewBookRepo.book['total_chapters'] =
//                           //     widget.chapters;
//
//
//                           UserBookRepo.mainBook = widget.books;
//                           var readChapters = {
//                             "status": false,
//                             "notes": [],
//                           };
//                           var totalChapters = 0;
//
//                           for (var i = 0; i < stateList.length; i++) {
//                             UserBookRepo.listOfBooks.add({
//                               'id': '',
//                               "book_name": bookName[i].text,
//                               "read_chapters": [],
//                               "read_status": false,
//                               "total_chapters": int.parse(
//                                   chapterLength[i].text),
//                             });
//                             totalChapters += int.parse(chapterLength[i].text);
//                           }
//
//
//                           UserBookRepo.numberOfChapters;
//                           for (var item in UserBookRepo.listOfBooks) {
//                             List<Map<String, dynamic>> readChapters = [];
//                             for (var i = 0; i < item['total_chapters']; i++) {
//                               readChapters.add({
//                                 "status": false,
//                                 "notes": [],
//                               });
//                             }
//                             item['read_chapters'] = readChapters;
//                           }
//                           print(UserBookRepo.listOfBooks);
//
//
//                           UserBookRepo.numberOfChapters = totalChapters;
//                           // for (var i = 0; i < widget.chapters; i++) {
//                           //   AddNewBookRepo.readChapters.add({
//                           //     "status": false,
//                           //     "notes": [],
//                           //   });
//                           // }
//                           // AddNewBookRepo.book['sub_headings'] =
//                           //     AddNewBookRepo.readChapters;
//                           context.read<AddNewBookCubit>().addBook();
//                         }
//                       }, child: BlocBuilder<AddNewBookCubit, AddNewBookState>(
//                         builder: (context, state) {
//                           if (state is AddNewBookLoading) {
//                             return Center(child: CircularProgressIndicator(),);
//                           } else {
//                             return Text('Submit');
//                           }
//                         },
//                       ),))
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );