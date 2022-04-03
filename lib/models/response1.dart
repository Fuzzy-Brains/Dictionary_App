// To parse this JSON data, do
//
//     final response1 = response1FromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Response1 response1FromJson(String str) => Response1.fromJson(json.decode(str));

String response1ToJson(Response1 data) => json.encode(data.toJson());

class Response1 {
  Response1({
    required this.statusCode,
    required this.developerMessage,
    required this.result,
  });

  int statusCode;
  String developerMessage;
  List<Result> result;

  factory Response1.fromJson(Map<String, dynamic> json) => Response1(
    statusCode: json["statusCode"],
    developerMessage: json["developerMessage"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "developerMessage": developerMessage,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.sNo,
    required this.word,
    required this.languageCode,
    required this.partOfSpeech,
    required this.definition,
  });

  int sNo;
  String word;
  String languageCode;
  String partOfSpeech;
  String definition;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    sNo: json["s_no"],
    word: json["word"],
    languageCode: json["language_code"],
    partOfSpeech: json["part_of_speech"],
    definition: json["definition"],
  );

  Map<String, dynamic> toJson() => {
    "s_no": sNo,
    "word": word,
    "language_code": languageCode,
    "part_of_speech": partOfSpeech,
    "definition": definition,
  };
}
