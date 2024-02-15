import 'dart:convert';

class GetSubPointCheckUnCheckResponseModel {
  int? statusCode;
  String? message;
  GetSubPointCheckUnCheckData? data;

  GetSubPointCheckUnCheckResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetSubPointCheckUnCheckResponseModel.fromRawJson(String str) => GetSubPointCheckUnCheckResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSubPointCheckUnCheckResponseModel.fromJson(Map<String, dynamic> json) => GetSubPointCheckUnCheckResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : GetSubPointCheckUnCheckData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class GetSubPointCheckUnCheckData {
  int? taskSubPointId;
  int? taskId;
  int? projectId;
  String? title;
  String? details;
  bool? isDone;
  bool? isActive;

  GetSubPointCheckUnCheckData({
    this.taskSubPointId,
    this.taskId,
    this.projectId,
    this.title,
    this.details,
    this.isDone,
    this.isActive,
  });

  factory GetSubPointCheckUnCheckData.fromRawJson(String str) => GetSubPointCheckUnCheckData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSubPointCheckUnCheckData.fromJson(Map<String, dynamic> json) => GetSubPointCheckUnCheckData(
    taskSubPointId: json["taskSubPointID"],
    taskId: json["taskID"],
    projectId: json["projectID"],
    title: json["title"],
    details: json["details"],
    isDone: json["isDone"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "taskSubPointID": taskSubPointId,
    "taskID": taskId,
    "projectID": projectId,
    "title": title,
    "details": details,
    "isDone": isDone,
    "isActive": isActive,
  };
}
