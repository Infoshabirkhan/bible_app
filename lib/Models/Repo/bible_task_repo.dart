import 'package:bible_app/Models/models/chapter_model.dart';
import 'package:bible_app/Models/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared_pref.dart';
import 'chapter_task_repo.dart';

class BibleTaskRepo {
  // static var user  = FirebaseAuth.instance.currentUser;
// static  List completedTask = [];

  var shared = SharedPrefs.getDefaultBook();

  // static var preDefineRef = FirebaseFirestore.instance
  //     .collection('BibleTask')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('userTask');
  // static var preDefineRef = FirebaseFirestore.instance
  //     .collection('user_books')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('userTask');
  static var newBookRef = FirebaseFirestore.instance
      .collection('user_books');

  //
  // static var taskRef = FirebaseFirestore.instance
  //     .collection('BibleTask')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('userTask');

// static var taskRef = FirebaseFirestore.instance
//     .collection('Books')
//     .doc(FirebaseAuth.instance.currentUser!.uid)
//     .collection('books');

//static Future<TaskModel> getNewBooks()async{
//   var book =   await SharedPrefs.getDefaultBook();
//
//   var data =await  newBookRef.doc(book!.bookId).get();
//  TaskModel model = TaskModel.fromJson(data.id, data);
//  return model;
//
// }

  static Future<Stream<List<TaskModel>>?> getNewBooks() async {
    var book = await SharedPrefs.getDefaultBook();
    print('============ new book ${book?.bookId}');


// TaskModel model = TaskModel.fromJson(data.id, data);
    var ref = await newBookRef.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books').where('book_id', isEqualTo: book?.bookId).snapshots().map((data) =>
        data.docs.map((book) => TaskModel.fromJson(book.id, book)).toList());
    return ref;
  }

  static Future<Stream<List<TaskModel>>?> getTask(
      {bool? isSortAscending = false}) async {
    //completedTask.clear();

    List completedChapters = [];
    List<TaskModel> list = [];

    try {
      var book = await SharedPrefs.getDefaultBook();

      // var ref;
      // if(book!.bookName == 'bible'){
      //  ref = await preDefineRef
      //       .get();
      // }else{
      //   ref = await newBookRef
      //       .get();
      // }
      var ref = await newBookRef.snapshots().map((data) =>
          data.docs.map((book) => TaskModel.fromJson(book.id, book)).toList());

      // if (ref != null) {
      //   return list;
      // } else {
      //   // for (var item in ref.docs) {
      //   //   TaskModel model = TaskModel.fromJson(item.id, item);
      //   //   list.add(model);
      //   // }
      //
      //   if(isSortAscending!){
      //     list.sort((a,b)=> a.totalChapters.compareTo(b.totalChapters));
      //
      //   }else{
      //     list.sort((a,b)=> a.id.compareTo(b.id));
      //
      //   }
      //
      //
      //
      //   ChapterModel.model.totalChapters = list.length;
      //   for(var item in list){
      //
      //     if(item.readStatus == true){
      //
      //       completedChapters.add(true);
      //       // completedTask.add(true);
      //     }else{
      //
      //     }
      //   }
      //
      //
      //  ChapterModel.model.completedChapters= completedChapters.length;
      return ref;
      // }
    } on FirebaseException catch (e) {
      print('============================');
      print(e.code);
      return null;
      // TODO
    }
  }

  static Future<bool> addNew({required TaskModel model}) async {
    var book = await SharedPrefs.getDefaultBook();

    var ref;
    // if (book!.bookId == 'bible') {
    //   ref = await preDefineRef.get();
    // } else {
      ref = await newBookRef.doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('books').get();
   // }
    await ref.add({
      "book_name": model.bookName,
      "chapter_name": model.totalChapters,
      "notes": model.notes,
      "created_date": model.createdDate,
    });

    return true;
  }

  static Future<bool> update({required TaskModel model}) async {
    try {
      var book = await SharedPrefs.getDefaultBook();

      var ref;
      // if (book!.bookId == 'bible') {
      //   ref = await preDefineRef;
      // } else {
        ref = await newBookRef.doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('books');
     // }
      await ref.doc(model.documentId).update(TaskModel.toJson(model));

      if (model.readStatus) {
        ++ChapterModel.model.readBooks;
      } else {
        --ChapterModel.model.readBooks;
      }
      await ChapterTaskRepo.chapterRef.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
            .doc(book?.bookId)
            .update({"read_books": ChapterModel.model.readBooks});

      return true;
    } on FirebaseException catch (e) {
      print('=========================== error ${e.code}');
      return false;
      // TODO
    }
  }
}

//static Future<List<TaskModel>?> getTask({bool? isSortAscending = false}) async {
