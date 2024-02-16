import 'dart:convert';

import '../../../../utils/utils.dart';

class UpdateTaskStatusAndPriorityRequestModel {
  int? taskId;
  int? projectId;
  TaskUpdateStatus? fieldName;
  String? fieldValue;

  UpdateTaskStatusAndPriorityRequestModel({
    this.taskId,
    this.projectId,
    this.fieldName,
    this.fieldValue,
  });

  factory UpdateTaskStatusAndPriorityRequestModel.fromRawJson(String str) => UpdateTaskStatusAndPriorityRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateTaskStatusAndPriorityRequestModel.fromJson(Map<String, dynamic> json) => UpdateTaskStatusAndPriorityRequestModel(
    taskId: json["taskID"],
    projectId: json["projectID"],
    fieldName: json["fieldName"],
    fieldValue: json["fieldValue"],
  );

  Map<String, dynamic> toJson() => {
    "taskID": taskId,
    "projectID": projectId,
    "fieldName": fieldName?.name,
    "fieldValue": fieldValue,
  };
}
