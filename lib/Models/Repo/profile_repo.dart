import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepo {
  static Future updateProfileInfo({
    File? image,
    required String address,
    required String url,
    required String name,
  }) async {


    if (image != null) {

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');
      UploadTask uploadTask = ref.putFile(
        image,
        SettableMetadata(contentType: 'image/png'),
      );
      TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {}).catchError((error) {});
      url = await taskSnapshot.ref.getDownloadURL();
      print("Uploading done");
    }

    var ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await ref.update({
      'address': address,
      "user_name": name,
      "profile_image": url
    });
  }
}
