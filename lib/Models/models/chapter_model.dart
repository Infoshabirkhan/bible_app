

import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel {
  static ChapterModel model = ChapterModel(
    documentId: '',
    totalChapters: 0,
    readBooks: 0,
    totalBooks: 0,
    completedChapters: 0, bookName: '',
  );
  int totalChapters;
  int completedChapters;
  int totalBooks;
  int readBooks;

  String documentId;
  String bookName;

  ChapterModel({
    required this.totalChapters,
    required this.completedChapters,
    required this.readBooks,
    required this.totalBooks,
    required this.documentId,
    required this.bookName
  });

  factory ChapterModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> json, String id) {
    return ChapterModel(
      bookName: json['book_name'],
      totalChapters: json['total_chapter'],
      completedChapters: json['completed_chapters'],
      totalBooks: json['total_books'],
      readBooks: json["read_books"],
      documentId: id,
    );
  }
}
