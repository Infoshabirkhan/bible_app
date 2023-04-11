import 'package:bible_app/Controllers/Cubits/chapter_cubit/chapter_cubit.dart';
import 'package:bible_app/Models/Repo/advertisement_repo.dart';
import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:bible_app/Views/Widgets/my_banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_notes_dialog.dart';
import 'notes_screen.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel model;

  const EditTaskScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  void initState() {
    AdvertisementRepo.showInterstitialAd();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController notesController = TextEditingController();

  Function(DateTime)? dateTime;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.model.bookName,
            style: GoogleFonts.raleway(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: BibleTaskRepo.taskRef
                    .doc(widget.model.documentId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    var data = snapshot.data;

                   var model =  TaskModel.fromJson(data!.id, data!);
                    return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        itemCount: widget.model.totalChapters,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.sp,
                          crossAxisSpacing: 10.sp,
                          mainAxisSpacing: 10.sp,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Checkbox(
                                          value: model.readChapters[index].status,
                                          onChanged: (bool? value) async {
                                            if (value != null) {
                                          //    var list = data['read_chapters'];
                                              var list = model.readChapters;

                                            //  if (list[index]['status'] ==
                                              if (list[index].status ==
                                                  false) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Form(
                                                        key: formKey,
                                                        child: NotesDailog(
                                                          selectedDate: dateTime,
                                                          controller:
                                                              notesController,
                                                          onSubmit: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              // list[index][
                                                              //         'status'] =
                                                              list[index].status =

                                                                  value;
                                                              list[index].notes[index].note =
                                                                  notesController
                                                                      .text
                                                                      .trim();

                                                              dateTime;
                                                              //  print('============== after list $list');
                                                              await BibleTaskRepo
                                                                  .taskRef
                                                                  .doc(widget
                                                                      .model
                                                                      .documentId)
                                                                  .update({
                                                                "read_chapters":
                                                                    list
                                                              });
                                                              context
                                                                  .read<
                                                                      ChapterCubit>()
                                                                  .setChapter(
                                                                      value:
                                                                          value);
                                                              notesController
                                                                  .clear();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            } else {}
                                                          },
                                                        ),
                                                      );
                                                    });
                                              } else {
                                                list[index].status = value;

                                                await BibleTaskRepo.taskRef
                                                    .doc(
                                                        widget.model.documentId)
                                                    .update({
                                                  "read_chapters": list
                                                });
                                                context
                                                    .read<ChapterCubit>()
                                                    .setChapter(value: value);
                                              }
                                            }
                                            // setState(() {});
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              "Ch # ${index + 1}",
                                              style: GoogleFonts.mulish(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context){


                                                return NotesScreen(model: model,notesIndex: index,);
                                              }));
                                              // showDialog(
                                              //     context: context,
                                              //     builder: (context) {
                                              //       return Dialog(
                                              //         child: Container(
                                              //           color: Colors.black,
                                              //           child: ListView(
                                              //             padding: EdgeInsets
                                              //                 .symmetric(
                                              //                     horizontal:
                                              //                         10.sp),
                                              //             shrinkWrap: true,
                                              //             children: [
                                              //               SizedBox(
                                              //                 height: 10.sp,
                                              //               ),
                                              //               SizedBox(
                                              //                 height: 50.sp,
                                              //                 child: Stack(
                                              //                   children: [
                                              //                     Center(
                                              //                       child: Text(
                                              //                         'Ch # ${index + 1}',
                                              //                         style: GoogleFonts
                                              //                             .raleway(
                                              //                           fontSize:
                                              //                               18.sp,
                                              //                           fontWeight:
                                              //                               FontWeight.w600,
                                              //                         ),
                                              //                       ),
                                              //                     ),
                                              //                     Positioned(
                                              //                       top: 10.sp,
                                              //                       right:
                                              //                           10.sp,
                                              //                       bottom: 0,
                                              //                       child:
                                              //                           IconButton(
                                              //                         onPressed:
                                              //                             () {
                                              //                           Navigator.of(context)
                                              //                               .pop();
                                              //                         },
                                              //                         icon:
                                              //                             const Icon(
                                              //                           Icons
                                              //                               .close,
                                              //                           color: Colors
                                              //                               .white,
                                              //                         ),
                                              //                       ),
                                              //                     ),
                                              //                   ],
                                              //                 ),
                                              //               ),
                                              //               Divider(),
                                              //
                                              //               SizedBox(
                                              //                 height: 10.sp,
                                              //               ),
                                              //               Text(
                                              //                 'Notes',
                                              //                 style: GoogleFonts
                                              //                     .raleway(
                                              //                   fontSize: 13.sp,
                                              //
                                              //                 ),
                                              //               ),
                                              //               SizedBox(
                                              //                 height: 5.sp,
                                              //               ),
                                              //               Text(
                                              //                 data['read_chapters']
                                              //                             [
                                              //                             index]
                                              //                         [
                                              //                         'notes'] ??
                                              //                     '',
                                              //                 style: GoogleFonts
                                              //                     .raleway(
                                              //                   fontSize: 16.sp,
                                              //                 ),
                                              //               ),
                                              //               SizedBox(
                                              //                 height: 20.sp,
                                              //               ),
                                              //               ElevatedButton(
                                              //                 onPressed: () {
                                              //                   Navigator.of(
                                              //                           context)
                                              //                       .pop();
                                              //                 },
                                              //                 child: const Text(
                                              //                     'Close'),
                                              //               ),
                                              //               SizedBox(
                                              //                 height: 10.sp,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //       );
                                              //     });
                                            },
                                            child: const Text('View Notes'),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text('something went wrong'),
                    );
                  }
                },
              ),
            ),
            const MyBannerAdWidget(),
          ],
        ));
  }
}
