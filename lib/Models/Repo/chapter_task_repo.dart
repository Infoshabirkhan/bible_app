

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chapter_model.dart';

class ChapterTaskRepo{
  // static var user  = FirebaseAuth.instance.currentUser;

  static var chapterRef = FirebaseFirestore.instance.collection('Chapter').doc(FirebaseAuth.instance.currentUser!.uid);

 static  Future <bool> setChapter({required bool isIncrement })async{


    try {

      if(isIncrement){
        ChapterModel.model = ChapterModel(chapterLength: ChapterModel.model.chapterLength+1);
      }else{
        ChapterModel.model = ChapterModel(chapterLength: ChapterModel.model.chapterLength-1);

      }

      await chapterRef.set({
        "total_chapter" : ChapterModel.model.chapterLength
      });


      return true;
    } on FirebaseException catch (e) {

      print(e.code);
      return false;

      // TODO
    }

  }



  static Future <bool> getChapter()async{
   print('=========== Firebase id ${FirebaseAuth.instance.currentUser!.uid}');
    ChapterModel.model = ChapterModel(chapterLength: 0);
   try {
     var ref = await chapterRef.get();

     if(ref.exists){
       ChapterModel.model = ChapterModel.fromJson(ref);

       return true;
     }else{
       ChapterModel.model = ChapterModel(chapterLength: 0);

       return true;

     }


   } on FirebaseException catch (e) {
     print(e.code);
     return false;
     // TODO
   }



  }
}