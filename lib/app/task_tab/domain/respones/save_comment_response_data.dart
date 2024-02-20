import 'dart:convert';

class SaveCommentDataResponseModel {
  int? statusCode;
  String? message;
  SaveCommentData? data;

  SaveCommentDataResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory SaveCommentDataResponseModel.fromRawJson(String str) => SaveCommentDataResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveCommentDataResponseModel.fromJson(Map<String, dynamic> json) => SaveCommentDataResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : SaveCommentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class SaveCommentData {
  int? taskLogDetailId;
  String? details;
  bool? isActive;
  int? taskId;
  int? projectId;
  int? createdBy;
  DateTime? createdOn;


  SaveCommentData({
    this.taskLogDetailId,
    this.details,
    this.isActive,
    this.taskId,
    this.projectId,
    this.createdBy,
    this.createdOn,

  });

  factory SaveCommentData.fromRawJson(String str) => SaveCommentData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveCommentData.fromJson(Map<String, dynamic> json) => SaveCommentData(
    taskLogDetailId: json["taskLogDetailID"],
    details: json["details"],
    isActive: json["isActive"],
    taskId: json["taskID"],
    projectId: json["projectID"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),

  );

  Map<String, dynamic> toJson() => {
    "taskLogDetailID": taskLogDetailId,
    "details": details,
    "isActive": isActive,
    "taskID": taskId,
    "projectID": projectId,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),

  };
}
