
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String bookName;
  final int totalChapters;
  final String notes;
  final Timestamp createdDate;
  final int id;
  final String documentId;
  final bool readStatus;
  final int completedChapters;
  final List<ReadChapter> readChapters;

  TaskModel({
    required this.bookName,
    required this.readChapters,
    required this.id,
    required this.documentId,
    required this.readStatus,
    required this.completedChapters,
    required this.totalChapters,
    required this.notes,
    required this.createdDate,
  });

  factory TaskModel.fromJson(String documentId, DocumentSnapshot<Map<String, dynamic>> json) {
    return TaskModel(
      id: json["id"],
      completedChapters: json["completed_chapter"],
      documentId: documentId,
      readStatus: json["read_status"],
      bookName: json["book_name"],
      totalChapters: json["total_chapters"],
      notes: json["notes"],
      // createdDate: json['created_date'],
      createdDate: json['created_date'],

      //json['read_chapters']
      // readChapters: json['read_chapters'],
      readChapters: List<ReadChapter>.from(json["read_chapters"].map((x) => ReadChapter.fromJson(x))),
    );
  }

  static Map<String, dynamic> toJson(TaskModel model){
    return {
      "book_name" : model.bookName,
      "total_chapters" : model.totalChapters,
      "notes": model.notes,
      "created_date" : model.createdDate,
      "read_status" : model.readStatus,
      "completed_chapter" : model.completedChapters
    };
  }



}
class ReadChapter {
  ReadChapter({
    required this.status,
   required this.notes,
  });

  bool status;
  List<Note> notes;

  factory ReadChapter.fromJson(Map<String, dynamic> json) => ReadChapter(
    status: json["status"],
    notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
  };
}

class Note {
  Note({
   required this.note,
   required this.dateTime,
  });

  String note;
  Timestamp? dateTime;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    note: json["note"],
    dateTime: json["date_time"],
  );

  Map<String, dynamic> toJson() => {
    "note": note,
    "date_time": dateTime,
  };
}

