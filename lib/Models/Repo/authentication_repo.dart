import 'package:bible_app/Models/Repo/chapter_task_repo.dart';
import 'package:bible_app/Models/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../models/default_book_model.dart';
import 'bible_book_repo.dart';

class AuthenticationRepo {
  static Future<bool> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();

        var docRef = FirebaseFirestore.instance
            .collection("BibleTask")
            .doc('${userCredential.user!.uid}')
            .collection('userTask');

        BibleBookRepo.bookList;

        var userRef = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid);
        await userRef.set({
          "user_name": userName,
          "join_date": Timestamp.now(),
          "profile_image": '',
          "address": '',
          "email": email,
          "password": password
        });

        for (var item in BibleBookRepo.bookList) {
          List<Map<String, dynamic>> readChapters = [];
          for (var i = 0; i < item['bible_chapters']; i++) {
            readChapters.add({
              "status": false,
              "notes": [],
            });
          }

          docRef.add({
            'id': item['id'],
            "book_name": item['name'],
            "read_chapters": readChapters,
            "read_status": false,
            "total_chapters": item['bible_chapters'],
//       "chapter_name" : null,

            'completed_chapter': 0,
            "notes": '',
            "created_date": Timestamp.now()
          });
          print('==================== added $item');
        }

        await ChapterTaskRepo.chapterRef.doc(FirebaseAuth.instance.currentUser!.uid).collection('books').doc("bible").set({
          "total_chapter": 1189,
          "completed_chapters": 0,
          "total_books": 66,
          "read_books": 0,
          "book_name" : "The Holy bible"
        });

        await SharedPrefs.setDefaultBook(
          DefaultBookModel(
            bookId: 'bible',
            bookName: 'The Holy Bible',
            isPreDefined: true,
            isList: true,
          ),
        );
        await FirebaseAuth.instance.signOut();
        await Future.delayed(Duration(seconds: 3));
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: getMessage(e.code), backgroundColor: Colors.red);
      print('============================== error ${e.message}');
      // Fluttertoast.showToast(msg: e.code);
      return false;
      // TODO
    }
  }

  static Future<bool> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print('==================== ${userCredential.user!.emailVerified}');
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        print('==================== in if condition');

        await SharedPrefs.setDefaultBook(
          DefaultBookModel(
            bookId: 'bible',
            bookName: 'The Holy Bible',
            isPreDefined: true,
            isList: true,
          ),
        );
        return true;
      } else if (!userCredential.user!.emailVerified) {
        Fluttertoast.showToast(
            msg: 'Email Not verified', backgroundColor: Colors.red);

        await FirebaseAuth.instance.signOut();

        return false;
      } else {
        print('===================');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: getMessage(e.code),
        backgroundColor: Colors.red,
      );

      print('============----------%%%%%%%%== eroor ${e.code}');
      return false;

      // TODO
    }
  }

  static String getMessage(code) {
    if (code == 'user-not-found') {
      return 'User not found with the given email';
    } else if (code == 'wrong-password') {
      return 'Wrong password try again';
    } else if (code == 'invalid-email') {
      return 'Invalid email format detected';
    } else {
      return code;
    }
  }
}
