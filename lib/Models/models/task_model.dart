
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String bookName;
  final int totalChapters;
  final String notes;
  final String? createdDate;
  final int id;
  final String documentId;
  final bool readStatus;
  final List completedChapters;
  final List readChapters;

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
      id: json['id'],
      completedChapters: json['completed_chapter'],
      documentId: documentId,
      readStatus: json['read_status'],
      bookName: json['book_name'],
      totalChapters: json['total_chapters'],
      notes: json['notes'],
      createdDate: json['created_date'],

      //json['read_chapters']
      readChapters: json['read_chapters'],
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
