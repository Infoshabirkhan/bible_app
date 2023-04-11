import 'package:cloud_firestore/cloud_firestore.dart';

class NotesController{


 static DateTime? dateTime;


 static String getDate(DateTime date){

  return '${date.month.toString().length == 1?'0${date.month}': '${date.month}'}-${date.day.toString().length == 1?'0${date.day}': '${date.day}'}-${date.year}';
  }

  static String getDateFromTimeStamp(Timestamp timestamp){

 var date = timestamp.toDate();
  return '${date.month.toString().length == 1?'0${date.month}': '${date.month}'}-${date.day.toString().length == 1?'0${date.day}': '${date.day}'}-${date.year}';
  }

}