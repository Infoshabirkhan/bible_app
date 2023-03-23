import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';

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

      if (userCredential.user != null) {
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
          "join_date" : Timestamp.now(),
          "profile_image" : '',
          "address" : ''
        });

        for (var item in BibleBookRepo.bookList) {
          List<bool> readChapters = [];
          for (var i = 0; i < item['bible_chapters']; i++) {
            readChapters.add(false);
          }

           docRef.add({
            'id': item['id'],
            "book_name": item['name'],
            "read_chapters": readChapters,
            "read_status": false,
            "total_chapters": item['bible_chapters'],
//       "chapter_name" : null,

            'completed_chapter': [],
            "notes": '',
            "created_date": null
          });
          print('==================== added $item');
        }

        await Future.delayed(Duration(seconds: 3));
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('============================== error ${e.code}');
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

      if (userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code,backgroundColor: Colors.red);
      print('============----------%%%%%%%%== eroor ${e.code}');
      return false;

      // TODO
    }
  }
}
