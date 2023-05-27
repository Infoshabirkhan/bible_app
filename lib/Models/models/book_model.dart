// // To parse this JSON data, do
// //
// //     final bookModel = bookModelFromJson(jsonString);
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// BookModel bookModelFromJson(String str, String id ) => BookModel.fromJson(json.decode(str), id);
//
// String bookModelToJson(BookModel data) => json.p(data.toJson());
//
// class BookModel {
//   final String name;
//   final String id;
//   final bool readStatus;
//   final List<SubHeading> subHeading;
//
//   BookModel({
//     required this.id,
//     required this.name,
//     required this.readStatus,
//     required this.subHeading,
//   });
//
//   factory BookModel.fromJson(QueryDocumentSnapshot <Map<String, dynamic>> json, String id) => BookModel(
//
//
//     id: id,
//     name: json["name"],
//     readStatus: json["read_status"],
//     subHeading: List<SubHeading>.from(json["sub_headings"].map((x) => SubHeading.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "read_status": readStatus,
//     "sub_headings": List<dynamic>.from(subHeading.map((x) => x.toJson())),
//   };
// }
//
// class SubHeading {
//   final List<Note> notes;
//   final bool status;
//
//   SubHeading({
//     required this.notes,
//     required this.status,
//   });
//
//   factory SubHeading.fromJson(Map<String, dynamic> json) => SubHeading(
//     notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
//     "status": status,
//   };
// }
//
// class Note {
//   final String note;
//   final String dateTime;
//
//   Note({
//     required this.note,
//     required this.dateTime,
//   });
//
//   factory Note.fromJson(Map<String, dynamic> json) => Note(
//     note: json["note"],
//     dateTime: json["date_time"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "note": note,
//     "date_time": dateTime,
//   };
// }
