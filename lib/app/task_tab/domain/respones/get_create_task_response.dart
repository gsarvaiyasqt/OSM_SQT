import 'dart:convert';

class GetCreateTaskResponseModel {
  int? statusCode;
  String? message;
  GetCreateTaskData? data;

  GetCreateTaskResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetCreateTaskResponseModel.fromRawJson(String str) => GetCreateTaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCreateTaskResponseModel.fromJson(Map<String, dynamic> json) => GetCreateTaskResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : GetCreateTaskData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class GetCreateTaskData {
  int? taskId;
  String? title;
  String? details;
  String? status;
  String? priority;
  DateTime? startDate;
  DateTime? endDate;
  int? projectId;
  DateTime? createdOn;

  GetCreateTaskData({
    this.taskId,
    this.title,
    this.details,
    this.status,
    this.priority,
    this.startDate,
    this.endDate,
    this.projectId,
    this.createdOn,
  });

  factory GetCreateTaskData.fromRawJson(String str) => GetCreateTaskData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCreateTaskData.fromJson(Map<String, dynamic> json) => GetCreateTaskData(
    taskId: json["taskID"],
    title: json["title"],
    details: json["details"],
    status: json["status"],
    priority: json["priority"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    projectId: json["projectID"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
  );

  Map<String, dynamic> toJson() => {
    "taskID": taskId,
    "title": title,
    "details": details,
    "status": status,
    "priority": priority,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "projectID": projectId,
    "createdOn": createdOn?.toIso8601String(),
  };
}
