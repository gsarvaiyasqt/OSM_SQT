// To parse this JSON data, do
//
//     final baseResModel = baseResModelFromJson(jsonString);

import 'dart:convert';

BaseResModel baseResModelFromJson(String str) => BaseResModel.fromJson(json.decode(str));

String baseResModelToJson(BaseResModel data) => json.encode(data.toJson());

class BaseResModel {
  int? statusCode;
  String? message;
  Data? data;

  BaseResModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory BaseResModel.fromJson(Map<String, dynamic> json) => BaseResModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? taskId;
  String? taskName;
  bool? startStop;

  Data({this.taskId, this.startStop, this.taskName});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    taskId: json["taskId"],
    taskName: json["taskName"],
    startStop: json["startStop"],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "taskName": taskName,
    "startStop": startStop,
  };
}
