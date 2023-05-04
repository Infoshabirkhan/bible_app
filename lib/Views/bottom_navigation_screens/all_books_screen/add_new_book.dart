import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/add_new_book_cubit.dart';
import 'package:bible_app/Controllers/Cubits/add_new_book_cubit/book_list_cubit.dart';
import 'package:bible_app/Models/Repo/add_new_book_repo.dart';
import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:bible_app/Views/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Models/utils/loading.dart';

class AddNewBook extends StatefulWidget {
  final String books;
  final int chapters;

  const AddNewBook({Key? key, required this.chapters, required this.books,})
      : super(key: key);

  @override
  State<AddNewBook> createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook> {
  // TextEditingController bookNameController = TextEditingController();
  // TextEditingController chapterController = TextEditingController();
  // TextEditingController b = TextEditingController();

  List<TextEditingController> controller = [];


  getController() {
    var list = context
        .read<BookListCubit>()
        .state;
    for (var i = 0; i < list; i++) {
      controller.add(TextEditingController());
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     showModalBottomSheet(context: context, builder: (context) {
      //       return Container(
      //         child: ListView(
      //           padding: EdgeInsets.symmetric(horizontal: 10.sp),
      //           children: [
      //             Text('Add Book'),
      //             MyTextField(
      //               controller: bookNameController, hintText: 'Book Name',),
      //           ],
      //         ),
      //       );
      //     });
      //   },
      //
      //   label: Text("Add New"),
      // ),
      appBar: AppBar(title: Text('Add book'),),
      body: BlocBuilder<BookListCubit, int>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(

                      itemCount: state,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.sp, horizontal: 10.sp),
                          child: Row(
                            children: [
                              Expanded(child: Text(
                                'Chapter ${index + 1}\nSub headings',),),
                              Expanded(
                                flex: 2,
                                child: MyTextField(


                                  keyboardType: TextInputType.number,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide sub headings';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller[index],
                                  hintText: 'Enter sub heading',),),
                            ],
                          ),
                        );
                      }),
                ),

                BlocListener<AddNewBookCubit, AddNewBookState>(
                  listener: (context, state) {
                    if(state is AddNewBookLoading){
                      showLoading(context, 'Please wait');
                    } if(state is AddNewBookDone){

                      Navigator.of(context).pop();

                      Fluttertoast.showToast(msg: 'Added Successfully');
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                        return BottomNavigationScreen();
                      }), (route) => false);

                    }if(state is AddNewBookError){
                      Navigator.of(context).pop();

                      Fluttertoast.showToast(msg: state.error);
                    }
                    // TODO: implement listener
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 10.sp),

                      width: 1.sw,
                      child: ElevatedButton(onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          AddNewBookRepo.book['book_name'] = widget.books;
                          AddNewBookRepo.book['total_chapters'] =
                              widget.chapters;

                          for (var i = 0; i < widget.chapters; i++) {
                            AddNewBookRepo.readChapters.add({
                              "status": false,
                              "notes": [],
                            });
                          }
                          AddNewBookRepo.book['sub_headings'] =
                              AddNewBookRepo.readChapters;
                          context.read<AddNewBookCubit>().addBook();
                        }
                      }, child: Text('Submit'),)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
