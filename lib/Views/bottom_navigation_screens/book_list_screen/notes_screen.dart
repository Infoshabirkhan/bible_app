import 'package:bible_app/Models/Repo/bible_task_repo.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesScreen extends StatefulWidget {
  final int notesIndex;
  final TaskModel model;
  const NotesScreen({Key? key,required this.model,required this.notesIndex,}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> listOfNotes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),

      ),
      body: StreamBuilder(
        stream: BibleTaskRepo.taskRef
            .doc(widget.model.documentId)
            .snapshots(),
        builder: (context, snapshot){

          if(snapshot.hasData && !snapshot.hasError){

            if(snapshot.data != null){
             var model =  TaskModel.fromJson(snapshot.data!.id, snapshot.data!);

             if(model.readChapters[widget.notesIndex].notes.isEmpty){

               return Center(child: Text('No Notes found'),);
             }else{
               return ListView.builder(

                   itemCount: model.readChapters[widget.notesIndex].notes.length,
                   itemBuilder: (context,index){
                    listOfNotes =  model.readChapters[widget.notesIndex].notes;
                    var notes =  listOfNotes[index];



                 return Container(height: 50.sp,child: Text(notes.note),);
               });
             }

            }else{
              return Center(child: Text('no found'),);
            }
          }else if (snapshot.connectionState == ConnectionState.waiting){

            return Center(child: CircularProgressIndicator(),);
          }else {
            return Center(child: Text('Something went wrong'),);
          }

        },
      ),
    );
  }
}
