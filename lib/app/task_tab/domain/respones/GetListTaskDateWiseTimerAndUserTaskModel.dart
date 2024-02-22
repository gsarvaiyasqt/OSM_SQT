import 'dart:convert';

import 'package:flutter/cupertino.dart';

class GetTaskDateWiseTimeResponseModel {
  int? statusCode;
  String? message;
  Data? data;

  GetTaskDateWiseTimeResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetTaskDateWiseTimeResponseModel.fromRawJson(String str) => GetTaskDateWiseTimeResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetTaskDateWiseTimeResponseModel.fromJson(Map<String, dynamic> json) => GetTaskDateWiseTimeResponseModel(
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
  List<TaskDateWiseTime>? taskDateWiseTime;
  List<UserTaskTimer>? userTaskTimer;

  Data({
    this.taskDateWiseTime,
    this.userTaskTimer,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    taskDateWiseTime: json["taskDateWiseTime"] == null ? [] : List<TaskDateWiseTime>.from(json["taskDateWiseTime"]!.map((x) => TaskDateWiseTime.fromJson(x))),
    userTaskTimer: json["userTaskTimer"] == null ? [] : List<UserTaskTimer>.from(json["userTaskTimer"]!.map((x) => UserTaskTimer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "taskDateWiseTime": taskDateWiseTime == null ? [] : List<dynamic>.from(taskDateWiseTime!.map((x) => x.toJson())),
  };
}

class TaskDateWiseTime {
  int? taskDateWiseTime;
  DateTime? taskDate;
  int? totalTimeInMinites;
  int? taskId;
  int? projectId;
  int? totalTimeInMinutesForClient;
  int? clientTimeUpdateBy;

  TaskDateWiseTime({
    this.taskDateWiseTime,
    this.taskDate,
    this.totalTimeInMinites,
    this.taskId,
    this.projectId,
    this.totalTimeInMinutesForClient,
    this.clientTimeUpdateBy,
  });

  factory TaskDateWiseTime.fromRawJson(String str) => TaskDateWiseTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskDateWiseTime.fromJson(Map<String, dynamic> json) => TaskDateWiseTime(
    taskDateWiseTime: json["TaskDateWiseTime"],
    taskDate: json["TaskDate"] == null ? null : DateTime.parse(json["TaskDate"]),
    totalTimeInMinites: json["TotalTimeInMinites"],
    taskId: json["TaskID"],
    projectId: json["ProjectID"],
    totalTimeInMinutesForClient: json["TotalTimeInMinutesForClient"],
    clientTimeUpdateBy: json["ClientTimeUpdateBy"],
  );

  Map<String, dynamic> toJson() => {
    "TaskDateWiseTime": taskDateWiseTime,
    "TaskDate": taskDate?.toIso8601String(),
    "TotalTimeInMinites": totalTimeInMinites,
    "TaskID": taskId,
    "ProjectID": projectId,
    "TotalTimeInMinutesForClient": totalTimeInMinutesForClient,
    "ClientTimeUpdateBy": clientTimeUpdateBy,
  };
}

class UserTaskTimer {
  int? userTaskTimerId;
  int? userId;
  int? taskId;
  DateTime? timerDate;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? oldTimerDate;
  DateTime? oldStartTime;
  DateTime? oldEndTime;
  int? projectId;
  int? totalTimeInMinites;
  int? totalTimeInMinutesForClient;
  String? displayName;
  String? profilePic;
  int? clientTimeUpdateBy;
  int? userTimeUpdateBy;
  String? clientTimeUpdateByDisplayName;
  String? userTimeUpdateByDisplayName;
  int? isAbleToUpdate;
  TextEditingController? textEditingController;

  UserTaskTimer({
    this.userTaskTimerId,
    this.userId,
    this.taskId,
    this.timerDate,
    this.startTime,
    this.endTime,
    this.projectId,
    this.totalTimeInMinites,
    this.totalTimeInMinutesForClient,
    this.displayName,
    this.profilePic,
    this.clientTimeUpdateBy,
    this.userTimeUpdateBy,
    this.clientTimeUpdateByDisplayName,
    this.userTimeUpdateByDisplayName,
    this.isAbleToUpdate,
    this.oldTimerDate,
    this.oldStartTime,
    this.oldEndTime,
    this.textEditingController
  });

  factory UserTaskTimer.fromRawJson(String str) => UserTaskTimer.fromJson(json.decode(str));



  factory UserTaskTimer.fromJson(Map<String, dynamic> json) => UserTaskTimer(
    userTaskTimerId: json["UserTaskTimerID"],
    userId: json["UserID"],
    taskId: json["TaskID"],
    timerDate: json["TimerDate"] == null ? null : DateTime.parse(json["TimerDate"]),
    startTime: json["StartTime"] == null ? null : DateTime.parse(json["StartTime"]),
    endTime: json["EndTime"] == null ? null : DateTime.parse(json["EndTime"]),
    projectId: json["ProjectID"],
    totalTimeInMinites: json["TotalTimeInMinites"],
    totalTimeInMinutesForClient: json["TotalTimeInMinutesForClient"],
    displayName: json["DisplayName"],
    profilePic: json["ProfilePic"],
    clientTimeUpdateBy: json["ClientTimeUpdateBy"],
    userTimeUpdateBy: json["UserTimeUpdateBy"],
    clientTimeUpdateByDisplayName: json["ClientTimeUpdateByDisplayName"],
    userTimeUpdateByDisplayName: json["UserTimeUpdateByDisplayName"],
    isAbleToUpdate: json["IsAbleToUpdate"],
  );


}

class TimeDetailsData{
  String? profilePic;
  DateTime? date;
  String? startDate;
  DateTime? endDate;
  String? clintMin;
  String? totalMns;
  List<UserTaskTimer>? userList;

  TimeDetailsData({this.profilePic,this.endDate,this.startDate,this.date,this.clintMin,this.totalMns,this.userList});

}
