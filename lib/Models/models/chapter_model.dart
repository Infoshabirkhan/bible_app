import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel{

  
  static ChapterModel model = ChapterModel(chapterLength: 0);
  final int chapterLength;

  ChapterModel({required this.chapterLength});

  factory ChapterModel.fromJson (DocumentSnapshot<Map<String, dynamic>> json){
    
    
    return ChapterModel(chapterLength: json['total_chapter']);
  }
}