// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.title,
    required this.message,
    required this.resolution,
  });

  String title;
  String message;
  String resolution;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    title: json["title"],
    message: json["message"],
    resolution: json["resolution"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "resolution": resolution,
  };
}
