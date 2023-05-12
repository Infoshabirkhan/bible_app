import 'package:bible_app/Models/Repo/chapter_task_repo.dart';
import 'package:bible_app/Models/models/book_model.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AddNewBookRepo {
  static Future<bool> addNewBook() async {
    try {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      var ref = FirebaseFirestore.instance
          .collection('Books')
          .doc(uid)
          .collection('books');

      // for (var item in subHeadings) {
      //   List<Map<String, dynamic>> readChapters = [];
      //   for (var i = 0; i < item['total_chapters']; i++) {
      //     readChapters.add({
      //       "status" : false,
      //       "notes" :[],
      //     });
      //   }}

      //for(var item in subHeadings){
      var doc = await ref.add(book);
      await ChapterTaskRepo.chapterRef.collection('books')
        ..doc(doc.id).set({
          "total_chapter": book["total_chapters"],
          "completed_chapters": 0,
          "total_books": 1,
          "read_books": 0,
        });
      // }

      return true;
    } on FirebaseFirestore catch (e) {
      rethrow;
      // TODO
    }
  }

  static Future<Stream<List<TaskModel>>?> getBooks() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;

    try {
      try {
        var ref = await FirebaseFirestore.instance
            .collection('Books')
            .doc(uid)
            .collection('books')
            .snapshots()
            .map((data) => data.docs
                .map((item) => TaskModel.fromJson(item.id, item))
                .toList());

        return ref;
      } on Exception catch (e) {
        rethrow;
        // TODO
      }
      //  BookModel.fromJson(ref, ref.id);

      // return FirebaseFirestore.instance.collection('Books').doc(uid).collection('books').snapshots().map((data) {
      //
      //   return data.docs.map((doc) {
      //     return BookModel.fromJson(doc, doc.id);
      //   }).toList();
      // });
    } on FirebaseException catch (e) {
      rethrow;
      // TODO
    }
  }

//  static Future<List<TaskModel>?> getBooks()async{
//
// var uid =  FirebaseAuth.instance.currentUser?.uid;
//
//     try {
//
//     var ref =   await FirebaseFirestore.instance.collection('Books').doc(uid).collection('books').get();
//
//     List<TaskModel> list = [];
//
//     for(var item in ref.docs ){
//
//   var data=     TaskModel.fromJson(item.id,item);
//
//   list.add(data);
//
//     }
//     return list;
//   //  BookModel.fromJson(ref, ref.id);
//
//
//       // return FirebaseFirestore.instance.collection('Books').doc(uid).collection('books').snapshots().map((data) {
//       //
//       //   return data.docs.map((doc) {
//       //     return BookModel.fromJson(doc, doc.id);
//       //   }).toList();
//       // });
//     } on FirebaseException catch (e) {
//       rethrow;
//       // TODO
//     }
//
//
//   }
  static Map<String, dynamic> book = {
    "id": 0,
    "book_name": '',
    "total_chapters": 0,
    "notes": "",
    "created_date": Timestamp.now(),
    "read_status": false,
    "read_chapters": readChapters,
    "completed_chapter": 0
    // "name" : '',
    //  "total_chapters" : "",
    //  "read_status": false
  };

  static List<Map<String, dynamic>> readChapters = [];
}
