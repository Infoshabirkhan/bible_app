// To parse this JSON data, do
//
//     final bibleBooksModel = bibleBooksModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BibleBooksModel bibleBooksModelFromJson(String str) => BibleBooksModel.fromJson(json.decode(str));

String bibleBooksModelToJson(BibleBooksModel data) => json.encode(data.toJson());

class BibleBooksModel {
  BibleBooksModel({
    required this.id,
    required this.name,
    required this.testament,
    required this.genre,
  });

  final int id;
  final String name;
  final String testament;
  final Genre genre;

  factory BibleBooksModel.fromJson(Map<String, dynamic> json) => BibleBooksModel(
    id: json["id"],
    name: json["name"],
    testament: json["testament"] ?? '',
    genre: Genre.fromJson(json["genre"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "testament": testament,
    "genre": genre.toJson(),
  };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
