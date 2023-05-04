

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/chapter_model.dart';

class ChapterTaskRepo{


  static var bookId = '';
  static var bookName = '';
  static var isPredefinedBook = false;
  static var isList = false;
  // static var user  = FirebaseAuth.instance.currentUser;

  static var chapterRef = FirebaseFirestore.instance.collection('Chapter').doc(FirebaseAuth.instance.currentUser!.uid);

 static  Future <bool> setChapter({required bool isIncrement })async{


    try {
      var chapter = ChapterModel.model;
      if(isIncrement){
       // ChapterModel.model = ChapterModel(completedChapters: chapter.completedChapters+1, readBooks: chapter.readBooks,totalBooks: chapter.totalBooks, totalChapters: chapter.totalChapters, );

         ChapterModel.model.completedChapters++;

      }else{
        if(ChapterModel.model.completedChapters == 0){
          ChapterModel.model.completedChapters = 0;

        }else{
          ChapterModel.model.completedChapters--;

        }

        //  ChapterModel.model = ChapterModel(completedChapters: ChapterModel.model.completedChapters-1,readBooks: chapter.readBooks,totalBooks: chapter.totalBooks, totalChapters: chapter.totalChapters, );

      }

      await chapterRef.collection('books').doc('bible').update({

        // "total_chapter" : ChapterModel.model.totalChapters,
         "completed_chapters" : ChapterModel.model.completedChapters
      });
      // await chapterRef.set({
      //   "total_chapter" : ChapterModel.model.chapterLength
      // });


      return true;
    } on FirebaseException catch (e) {

      print(e.code);
      return false;

      // TODO
    }

  }



  static Future <bool> getChapter()async{
   print('=========== Firebase id ${FirebaseAuth.instance.currentUser!.uid}');
   ChapterModel.model = ChapterModel(completedChapters: 0, readBooks: 0,totalBooks: 0, totalChapters: 0, );
   try {
     var ref = await chapterRef.collection('books').doc(bookId).get();

     if(ref.exists){
       ChapterModel.model = ChapterModel.fromJson(ref);

       return true;
     }else{
       ChapterModel.model = ChapterModel(completedChapters: 0, readBooks: 0,totalBooks: 0, totalChapters: 0, );

       return true;

     }


   } on FirebaseException catch (e) {
     print(e.code);
     print('============================= error');
     Fluttertoast.showToast(msg: e.code);
     return false;
     // TODO
   }



  }
}