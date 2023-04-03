import 'package:bible_app/Controllers/Cubits/bible_task_cubit/bible_task_cubit.dart';
import 'package:bible_app/Models/Repo/advertisement_repo.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:bible_app/Views/bottom_navigation_screens/book_list_screen/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Models/models/bible_books.dart';

class BookCard extends StatelessWidget {
  final TaskModel data;

  const BookCard({Key? key, required this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
       // await  AdvertisementRepo.createInterstitialAd();

        Navigator.of(context).push(MaterialPageRoute(builder: (context){

          return EditTaskScreen(model: data);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.grey
                )
            )
        ),
        height: 70.sp,
        child: Row(
          children: [


            Expanded(child: Container(
              child: Checkbox(
                onChanged: (x) {

                  context.read<BibleTaskCubit>().update(model: TaskModel(bookName: data.bookName, id: data.id, documentId: data.documentId, readStatus: !data.readStatus, totalChapters: data.totalChapters, notes: 'notes', createdDate: 'createdDate',completedChapters: data.completedChapters, readChapters: data.readChapters));
//                                  context.read<BibleTaskCubit>().addNew(model: TaskModel(bookName: data.bookName, chapterName: '1', notes: 'Dummy notes', createdDate: 'date', readStatus: true, id: data.id));
                }, value:data.readStatus,
              ),
            ),),

            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Expanded(child:
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        data.bookName, style: GoogleFonts.poppins(

                      ),),
                    ),
                  ),),

                  Expanded(child: Center(child: Text(data.totalChapters.toString(),style: GoogleFonts.poppins(),)),),

                  Expanded(child: Icon(Icons.arrow_forward_ios))
                ],
              ),),


          ],
        ),
      ),
    );
  }
}



//    return BlocListener<BibleTaskCubit, BibleTaskState>(
//   listener: (context, state) {
// 
//     if(state is BibleTaskAddingEntry ){
//       ScaffoldMessenger.of(context)..showSnackBar(SnackBar(content: Text('Loading')));
//     } if(state is BibleTaskDataAdded ){
//       context.read<BibleTaskCubit>().getTaskInfo();
//     }
//     // TODO: implement listener
//   },
//   child: BlocBuilder<BibleTaskCubit, BibleTaskState>(
//       builder: (context, state) {
//         if(state is BibleTaskLoaded){
//           return Column(
//             // primary: false,
//             // physics: NeverScrollableScrollPhysics(),
//             children: [
//               Expanded(
//                 child: Container(
//                   child: Row(
//                     children: [
// 
// 
//                       Spacer(),
//                       Expanded(
//                         flex: 5,
//                         child: Row(
//                           children: [
//                             Expanded(child:
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: FittedBox(
//                                 child: Text('Books', style: GoogleFonts.poppins(
// 
//                                 ),),
//                               ),
//                             ),),
// 
// 
// 
//                             Expanded(child: Center(
//                               child: FittedBox(
//                                 child: Text('Chapter',style: GoogleFonts.poppins(
// 
// 
//                                 ),),
//                               ),
//                             ),),
// 
//                             Spacer()
//                             // Expanded(child: Center(
//                             //
//                             //   child: FittedBox(
//                             //     child: Text('Related Notes',style: GoogleFonts.poppins(
//                             //
//                             //
//                             //     ),),
//                             //   ),
//                             // ),),
// 
// 
//                           ],
//                         ),),
// 
//                       
// 
//                     ],
//                   ),
//                 ),
//               ),
// 
// 
//               Expanded(
//                 flex: 9,
//                 child: ListView.builder(
// 
//                     padding: EdgeInsets.symmetric(horizontal: 5.sp,),
//                     itemCount: state.model.length,
//                     itemBuilder: (context, index) {
//                       var data =  state.model[index];
//                       return Container(
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                                     color: Colors.grey
//                                 )
//                             )
//                         ),
//                         height: 70.sp,
//                         child: Row(
//                           children: [
// 
// 
//                             Expanded(child: Container(
//                               child: Checkbox(
//                                 onChanged: (x) {
// 
//                                   context.read<BibleTaskCubit>().update(model: TaskModel(bookName: data.bookName, id: data.id, documentId: data.documentId, readStatus: !data.readStatus, chapterName: data.chapterName, notes: 'notes', createdDate: 'createdDate',));
// //                                  context.read<BibleTaskCubit>().addNew(model: TaskModel(bookName: data.bookName, chapterName: '1', notes: 'Dummy notes', createdDate: 'date', readStatus: true, id: data.id));
//                                 }, value:data.readStatus,
//                               ),
//                             ),),
// 
//                             Expanded(
//                               flex: 5,
//                               child: Row(
//                                 children: [
//                                   Expanded(child:
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: FittedBox(
//                                       child: Text(
//                                         data.bookName, style: GoogleFonts.poppins(
// 
//                                       ),),
//                                     ),
//                                   ),),
//                                   
//                                   Expanded(child: Center(child: Text(data.chapterName?? '0',style: GoogleFonts.poppins(),)),),
// 
//                                   Expanded(child: Icon(Icons.arrow_forward_ios))
//                                 ],
//                               ),),
// 
// 
//                           ],
//                         ),
//                       );
//                     }),
//               )
//             ],
//           );
// 
//         }else{
//           return Center(child: CircularProgressIndicator(),);
//         }
//       },
//     ),
// );