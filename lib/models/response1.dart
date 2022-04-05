// To parse this JSON data, do
//
//     final response1 = response1FromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Response1 response1FromJson(String str) => Response1.fromJson(json.decode(str));

String response1ToJson(Response1 data) => json.encode(data.toJson());

class Response1 {
  Response1({
    required this.id,
    required this.english,
    required this.hindi,
    required this.chhattisgarhi,
  });

  int id;
  String english;
  String hindi;
  String chhattisgarhi;

  factory Response1.fromJson(Map<String, dynamic> json) => Response1(
    id: json["id"],
    english: json["english"],
    hindi: json["hindi"],
    chhattisgarhi: json["chhattisgarhi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "english": english,
    "hindi": hindi,
    "chhattisgarhi": chhattisgarhi,
  };
}
