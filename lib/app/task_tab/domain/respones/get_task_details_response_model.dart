import 'dart:convert';

import 'package:osm_flutter/app/task_tab/domain/respones/get_list_task_data_model.dart';

class GetTaskDetailsResponseModel {
  int? statusCode;
  String? message;
  TaskDetailsData? data;

  GetTaskDetailsResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetTaskDetailsResponseModel.fromRawJson(String str) => GetTaskDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetTaskDetailsResponseModel.fromJson(Map<String, dynamic> json) => GetTaskDetailsResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : TaskDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class TaskDetailsData {
  Task? task;
  List<TaskSubpoint>? taskSubpoints;
  List<TaskUser>? taskUser;
  List<Document>? documents;

  TaskDetailsData({
    this.task,
    this.taskSubpoints,
    this.taskUser,
    this.documents,
  });

  factory TaskDetailsData.fromRawJson(String str) => TaskDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskDetailsData.fromJson(Map<String, dynamic> json) => TaskDetailsData(
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    taskSubpoints: json["taskSubpoints"] == null ? [] : List<TaskSubpoint>.from(json["taskSubpoints"]!.map((x) => TaskSubpoint.fromJson(x))),
    taskUser: json["taskUser"] == null ? [] : List<TaskUser>.from(json["taskUser"]!.map((x) => TaskUser.fromJson(x))),
    documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "task": task?.toJson(),
    "taskSubpoints": taskSubpoints == null ? [] : List<dynamic>.from(taskSubpoints!.map((x) => x.toJson())),
    "taskUser": taskUser == null ? [] : List<dynamic>.from(taskUser!.map((x) => x.toJson())),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
  };
}

class Task {
  int? taskId;
  String? title;
  String? details;
  String? status;
  String? priority;
  DateTime? startDate;
  DateTime? endDate;
  int? projectId;
  int? isActive;
  DateTime? lastUpdateOn;
  int? lastUpdateBy;
  int? createdBy;
  DateTime? createdOn;
  DateTime? actualStartDate;
  DateTime? actualEndDate;
  String? projectName;

  Task({
    this.taskId,
    this.title,
    this.details,
    this.status,
    this.priority,
    this.startDate,
    this.endDate,
    this.projectId,
    this.isActive,
    this.lastUpdateOn,
    this.lastUpdateBy,
    this.createdBy,
    this.createdOn,
    this.actualStartDate,
    this.actualEndDate,
    this.projectName,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    taskId: json["TaskID"],
    title: json["Title"],
    details: json["Details"],
    status: json["Status"],
    priority: json["Priority"],
    startDate: json["StartDate"] == null ? null : DateTime.parse(json["StartDate"]),
    endDate: json["EndDate"] == null ? null : DateTime.parse(json["EndDate"]),
    projectId: json["ProjectID"],
    isActive: json["IsActive"],
    lastUpdateOn: json["LastUpdateOn"] == null ? null : DateTime.parse(json["LastUpdateOn"]),
    lastUpdateBy: json["LastUpdateBy"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    actualStartDate: json["ActualStartDate"] == null ? null : DateTime.parse(json["ActualStartDate"]),
    actualEndDate: json["ActualEndDate"] == null ? null : DateTime.parse(json["ActualEndDate"]),
    projectName: json["ProjectName"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "Title": title,
    "Details": details,
    "Status": status,
    "Priority": priority,
    "StartDate": startDate?.toIso8601String(),
    "EndDate": endDate?.toIso8601String(),
    "ProjectID": projectId,
    "IsActive": isActive,
    "LastUpdateOn": lastUpdateOn?.toIso8601String(),
    "LastUpdateBy": lastUpdateBy,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "ActualStartDate": actualStartDate?.toIso8601String(),
    "ActualEndDate": actualEndDate?.toIso8601String(),
    "ProjectName": projectName,
  };
}

class TaskSubpoint {
  int? taskSubPointId;
  int? taskId;
  int? projectId;
  String? title;
  String? details;
  int? isDone;
  int? isActive;
  int? createdBy;
  DateTime? createdOn;

  TaskSubpoint({
    this.taskSubPointId,
    this.taskId,
    this.projectId,
    this.title,
    this.details,
    this.isDone,
    this.isActive,
    this.createdBy,
    this.createdOn,
  });

  factory TaskSubpoint.fromRawJson(String str) => TaskSubpoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskSubpoint.fromJson(Map<String, dynamic> json) => TaskSubpoint(
    taskSubPointId: json["TaskSubPointID"],
    taskId: json["TaskID"],
    projectId: json["ProjectID"],
    title: json["Title"],
    details: json["Details"],
    isDone: json["IsDone"],
    isActive: json["IsActive"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
  );

  Map<String, dynamic> toJson() => {
    "TaskSubPointID": taskSubPointId,
    "TaskID": taskId,
    "ProjectID": projectId,
    "Title": title,
    "Details": details,
    "IsDone": isDone,
    "IsActive": isActive,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
  };
}

class TaskUser {
  int? taskUserId;
  int? taskId;
  int? userId;
  int? projectId;
  int? isActive;
  int? isAssign;
  int? isTeamLead;
  int? isManager;
  int? createdBy;
  DateTime? createdOn;
  String? displayName;
  String? profilePic;
  String? userName;

  TaskUser({
    this.taskUserId,
    this.taskId,
    this.userId,
    this.projectId,
    this.isActive,
    this.isAssign,
    this.createdBy,
    this.createdOn,
    this.displayName,
    this.profilePic,
    this.userName,
    this.isTeamLead,
    this.isManager
  });

  factory TaskUser.fromRawJson(String str) => TaskUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskUser.fromJson(Map<String, dynamic> json) => TaskUser(
    taskUserId: json["TaskUserID"],
    taskId: json["TaskID"],
    userId: json["UserID"],
    projectId: json["ProjectID"],
    isActive: json["IsActive"],
    isAssign: json["IsAssign"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    displayName: json["DisplayName"],
    profilePic: json["ProfilePic"],
    userName: json["UserName"],
    isManager: json["IsManager"],
    isTeamLead: json["IsTeamLead"]
  );

  Map<String, dynamic> toJson() => {
    "TaskUserID": taskUserId,
    "TaskID": taskId,
    "UserID": userId,
    "ProjectID": projectId,
    "IsActive": isActive,
    "IsAssign": isAssign,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "DisplayName": displayName,
    "ProfilePic": profilePic,
    "UserName": userName,
  };
}
