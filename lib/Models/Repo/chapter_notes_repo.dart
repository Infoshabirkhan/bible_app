import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';
import 'bible_task_repo.dart';

class ChapterNotesRepo {
 static Future<Stream<TaskModel>?> getChapterNotes({required String bookId}) async {
    try {
      return BibleTaskRepo.newBookRef
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('books')
          .doc(bookId)
          .snapshots()
          .map(
            (event) => TaskModel.fromJson(event.id, event),
          );
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }
}
