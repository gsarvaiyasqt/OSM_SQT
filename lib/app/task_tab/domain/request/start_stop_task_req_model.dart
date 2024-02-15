// To parse this JSON data, do
//
//     final startTaskReqModel = startTaskReqModelFromJson(jsonString);

import 'dart:convert';

StartStopTaskReqModel startTaskReqModelFromJson(String str) => StartStopTaskReqModel.fromJson(json.decode(str));

String startTaskReqModelToJson(StartStopTaskReqModel data) => json.encode(data.toJson());

class StartStopTaskReqModel {
  int? taskId;
  int? projectId;
  String? stopTaskComment;

  StartStopTaskReqModel({
    this.taskId,
    this.projectId,
    this.stopTaskComment,
  });

  factory StartStopTaskReqModel.fromJson(Map<String, dynamic> json) => StartStopTaskReqModel(
    taskId: json["taskID"],
    projectId: json["projectID"],
    stopTaskComment: json["stopTaskComment"],
  );

  Map<String, dynamic> toJson() => {
    "taskID": taskId,
    "projectID": projectId,
    "stopTaskComment": stopTaskComment,
  };
}
