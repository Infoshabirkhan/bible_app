import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel{

  
  static ChapterModel model = ChapterModel(totalChapters: 0, readBooks: 0,totalBooks: 0, completedChapters: 0,);
  int totalChapters;
  int completedChapters;
  int totalBooks;
  int readBooks;

  ChapterModel({required this.totalChapters, required this.completedChapters,required this.readBooks,required this.totalBooks,});

  factory ChapterModel.fromJson (DocumentSnapshot<Map<String, dynamic>> json){
    
    
    return ChapterModel(

      totalChapters: json['total_chapter'],
    completedChapters: json['completed_chapters'],
      totalBooks: json['total_books'],
      readBooks: json["read_books"],


    );
  }
}