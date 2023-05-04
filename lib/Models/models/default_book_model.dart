// To parse this JSON data, do
//
//     final defaultBookModel = defaultBookModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DefaultBookModel defaultBookModelFromJson(String str) => DefaultBookModel.fromJson(json.decode(str));

String defaultBookModelToJson(DefaultBookModel data) => json.encode(data.toJson());

class DefaultBookModel {
  final String bookId;
  final String bookName;
  final bool isPreDefined;
  final bool isList;

  DefaultBookModel({
    required this.bookId,
    required this.bookName,
    required this.isPreDefined,
    required this.isList,
  });

  factory DefaultBookModel.fromJson(Map<String, dynamic> json) => DefaultBookModel(
    bookId: json["book_id"],
    bookName: json["book_name"],
    isPreDefined: json["is_pre_defined"],
    isList: json["is_list"],
  );

  Map<String, dynamic> toJson() => {
    "book_id": bookId,
    "book_name": bookName,
    "is_pre_defined": isPreDefined,
    "is_list": isList,
  };
}
