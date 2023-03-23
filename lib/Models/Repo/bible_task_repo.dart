import 'package:bible_app/Models/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BibleTaskRepo {
  // static var user  = FirebaseAuth.instance.currentUser;
static  List completedTask = [];

  static var taskRef = FirebaseFirestore.instance
      .collection('BibleTask')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('userTask');
  static Future<List<TaskModel>?> getTask({bool? isSortAscending = false}) async {

    completedTask.clear();
    List<TaskModel> list = [];

    try {
      var ref = await taskRef
          .get();

      if (ref.docs.isEmpty) {
        return list;
      } else {
        for (var item in ref.docs) {
          TaskModel model = TaskModel.fromJson(item.id, item);
          list.add(model);
        }

        if(isSortAscending!){
          list.sort((a,b)=> a.totalChapters.compareTo(b.totalChapters));

        }else{
          list.sort((a,b)=> a.id.compareTo(b.id));

        }



        for(var item in list){

          if(item.readStatus == true){
            completedTask.add(true);
          }else{

          }
        }

        return list;
      }
    } on FirebaseException catch (e) {
      print('============================');
      print(e.code);
      return null;
      // TODO
    }
  }


  static Future <bool> addNew({required TaskModel model})async{

await     taskRef.add({

    "book_name" : model.bookName,
    "chapter_name" : model.totalChapters,
    "notes": model.notes,
    "created_date" : model.createdDate,

    });

  return true;
  }



  static Future<bool> update({required TaskModel model}) async {

  try {
    await   taskRef.doc(model.documentId).update(TaskModel.toJson(model));

      return true;
  } on FirebaseException catch (e) {
    print('=========================== error ${e.code}');
    return false;
    // TODO
  }
  }




}
