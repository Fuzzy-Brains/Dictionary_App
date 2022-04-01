// To parse this JSON data, do
//
//     final word = wordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Word wordFromJson(String str) => Word.fromJson(json.decode(str));

String wordToJson(Word data) => json.encode(data.toJson());

class Word {
  Word({
    required this.word,
    required this.score,
    // required this.tags,
  });

  String word;
  int score;
  // List<String> tags;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    word: json["word"],
    score: json["score"],
    // tags: List<String>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "score": score,
    // "tags": List<dynamic>.from(tags.map((x) => x)),
  };
}
