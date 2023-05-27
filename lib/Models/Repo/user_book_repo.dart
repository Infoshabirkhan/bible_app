import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserBookRepo {
 static Future addNewBook() async {
    try {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      var ref = FirebaseFirestore.instance
          .collection('user_books')
          .doc(uid)
          .collection('books');

      var customBook = FirebaseFirestore.instance
          .collection('Chapter')
          .doc(uid)
          .collection('books');
   var docId =    await customBook.add({
        "book_name": mainBook,
        "completed_chapters": 0,
        "read_books": 0,
        "total_books": listOfBooks.length,
        "total_chapter": numberOfChapters
      });

   print('==================document id  ${docId.id}');
      for (var i = 0; i < listOfBooks.length; i++) {
        print('===================adding $i');
        await ref.add({
          'id': 0,
          "book_name": listOfBooks[i]['book_name'],
          "completed_chapter" :0,
          "created_date" :null,
          "notes" :'',
          "read_chapters": listOfBooks[i]['read_chapters'],
          "read_status": false,
          "total_chapters": listOfBooks[i]['total_chapters'],
          "book_id" : docId.id
        });
      }

      numberOfChapters = 0;
      mainBook = '';
      listOfBooks = [];
      return true;
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }

 static List<Map<String, dynamic>> listOfBooks = [];

  static var readChaptersStructure = {
    "status": false,
    "notes": [],
  };


  static var  mainBook = '';
  static var  numberOfChapters = 0;
  static Map<String, dynamic> bookStructure = {
    'id': '',
    "book_name": '',
    "read_chapters": readChaptersStructure,
    "read_status": false,
    "total_chapters": 0,
  };
}
