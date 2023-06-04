import 'package:bible_app/Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'package:bible_app/Controllers/notes_controller.dart';
import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:bible_app/Models/utils/internet_connectivity.dart';
import 'package:bible_app/Views/Widgets/logout_alert_dialog.dart';
import 'package:bible_app/Views/bottom_navigation_screens/book_list_screen/add_notes_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Models/shared_pref.dart';

class NotesScreen extends StatefulWidget {
  final int notesIndex;
  final TaskModel model;

  const NotesScreen({
    Key? key,
    required this.model,
    required this.notesIndex,
  }) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController notesController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  var ref=BibleTaskRepo. newBookRef.doc('hjhj');

  var book ;
  getRef()async{
    await   SharedPrefs.getDefaultBook();
    var book =   await SharedPrefs.getDefaultBook();

    // if(book!.bookId =='bible'){
    //   setState(() {
    //     ref = BibleTaskRepo. preDefineRef.doc(widget.model.documentId);
    //
    //   });
    //
    // }else{

      setState(() {
        ref = BibleTaskRepo.newBookRef.doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('books')
            .doc(widget.model.documentId);
      });

   // }
  }
  List listOfNotes = [];

  @override
  void initState() {

    getRef();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Form(
                  key: formKey,
                  child: NotesDailog(
                    dateController: dateController,
                    controller: notesController,
                    onSubmit: () async {


                      if (await InternetConnectivity.isNotConnected()) {
                        await Future.delayed(Duration(seconds: 1));
                        Fluttertoast.showToast(msg: 'No Internet Connection',backgroundColor: Colors.red);
                        Navigator.of(context).pop();
                        return;
                      }
                      if (formKey.currentState!.validate()) {

                        List readJson = [];

                        var readList = widget.model.readChapters;

                        for (var item in readList) {
                          List notes = [];
                          for(var i=0;i<item.notes.length;i++){
                            notes.add({
                              "note": item.notes[i].note,
                              "date_time": item.notes[i].dateTime,
                            });
                          }
                          readJson.add(
                              {"status": item.status, "notes": notes});
                        }


                        var notesList = readList[widget.notesIndex].notes;

                        Timestamp timeStamp =
                            Timestamp.fromDate(NotesController.dateTime!);

                        notesList.add(Note.fromJson({
                          "note": notesController.text.trim(),
                          "date_time": timeStamp
                        }));

                    ///  await  Future.delayed(Duration(milliseconds: 1000));
                        List<Map<String, dynamic>> notesToJson = [];

                        for (var item in notesList) {
                          notesToJson.add({
                            "note": item.note,
                            "date_time": item.dateTime,
                          });
                        }

                        readJson[widget.notesIndex]['notes'] = notesToJson;

                       print('==========readjson ${readJson}');
                        try {
                          await ref
                              .update({"read_chapters": readJson});
                        } on Exception catch (e) {
                          print('========== execption ${e.toString()}');
                          // TODO
                        }

                        notesController.clear();
                        NotesController.dateTime = null;

                        dateController.clear();
                        Navigator.of(context).pop();
                      } else {}
                    },
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            if (snapshot.data != null) {
              var model = TaskModel.fromJson(snapshot.data!.id, snapshot.data!);

              listOfNotes =
                  snapshot.data!['read_chapters'][widget.notesIndex]['notes'];
              if (model.readChapters[widget.notesIndex].notes.isEmpty) {
                return Center(
                  child: Text('No Notes found added'),
                );
              } else {
                return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    itemCount:
                        model.readChapters[widget.notesIndex].notes.length,
                    itemBuilder: (context, index) {
                      var notes =
                          model.readChapters[widget.notesIndex].notes[index];

                      return Container(
                          margin: EdgeInsets.only(bottom: 15.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.sp),
                              border: Border.all(color: Colors.grey)),
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          height: 95.sp,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: notes.dateTime == null
                                          ? SizedBox()
                                          : Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                NotesController
                                                    .getDateFromTimeStamp(
                                                        notes.dateTime!),
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return MyAlertDialog(
                                                  title: 'Confirmation!!!',
                                                  content:
                                                      'Are you sure to remove?',
                                                  onSubmit: () async {


                                                    if (await InternetConnectivity.isNotConnected()) {
                                                      await Future.delayed(Duration(seconds: 1));
                                                      Fluttertoast.showToast(msg: 'No Internet Connection',backgroundColor: Colors.red);
                                                      Navigator.of(context).pop();
                                                      return;
                                                    }
                                                    List readJson = [];

                                                    var readList =
                                                        model.readChapters;

                                                    for (var item in readList) {

                                                      List notes = [];
                                                      for(var i=0;i<item.notes.length;i++){
                                                        notes.add({
                                                          "note": item.notes[i].note,
                                                          "date_time": item.notes[i].dateTime,
                                                        });
                                                      }
                                                      readJson.add({
                                                        "status": item.status,
                                                        "notes": notes
                                                      });
                                                    }

                                                    List list = readJson[widget
                                                        .notesIndex]['notes'];

                                                    await list.removeAt(index);

                                                    print(
                                                        '============== read json${list}');
                                                    // List<Map<String, dynamic>>
                                                    //     notesToJson = list;
                                                    // for (var item in list) {
                                                    //   notesToJson.add({
                                                    //     "note": item.note,
                                                    //     "date_time":
                                                    //         item.dateTime,
                                                    //   });
                                                    // }

                                                    readJson[widget.notesIndex]
                                                        ['notes'] = list;

                                                    await ref
                                                        .update({
                                                      "read_chapters": readJson
                                                    });

                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      notes.note,
                                      style: TextStyle(fontSize: 16.sp),
                                    )),
                              ),
                            ],
                          ));
                    });
              }
            } else {
              return Center(
                child: Text('no found'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
