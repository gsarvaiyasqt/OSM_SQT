// To parse this JSON data, do
//
//     final getRunningTaskDetailsResModel = getRunningTaskDetailsResModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

GetRunningTaskDetailsResModel getRunningTaskDetailsResModelFromJson(String str) => GetRunningTaskDetailsResModel.fromJson(json.decode(str));

String getRunningTaskDetailsResModelToJson(GetRunningTaskDetailsResModel data) => json.encode(data.toJson());

class GetRunningTaskDetailsResModel {
  int? statusCode;
  String? message;
  List<RunningTaskData>? data;

  GetRunningTaskDetailsResModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetRunningTaskDetailsResModel.fromJson(Map<String, dynamic> json) {
    print("${json["data"].runtimeType} ====  check Runtime");

    if(json["data"] is Map){

      return GetRunningTaskDetailsResModel(
        statusCode: json["status_code"],
        message: json["message"],
      );

    }

    return GetRunningTaskDetailsResModel(
      statusCode: json["status_code"],
      message: json["message"],
      data: json["data"] == null ? [] : List<RunningTaskData>.from(json["data"].map((x) => RunningTaskData.fromJson(x))),
    );

  }

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RunningTaskData {
  int? userTaskTimerId;
  int? userId;
  int? taskId;
  DateTime? timerDate;
  DateTime? startTime;
  String? title;
  String? status;
  String? priority;
  int? projectId;
  String? projectName;
  String? projectLogo;

  RunningTaskData({
    this.userTaskTimerId,
    this.userId,
    this.taskId,
    this.timerDate,
    this.startTime,
    this.title,
    this.status,
    this.priority,
    this.projectId,
    this.projectName,
    this.projectLogo,
  });

  String? get sDate {

    if (startTime == null) {
      return null;
    }

    return DateFormat('hh:mm').format(startTime ?? DateTime.now());

  }


  Duration? get duration {

    if (startTime == null) {
      return null;
    }

    final isTEst = DateTime.now().difference(startTime!);
    // var hours = DateFormat('hh').format(isTEst!);
    // var minutes = DateFormat('mm').format(startTime!);
    // var seconds = DateFormat('ss').format(startTime!);
    return isTEst;
    // return Duration(seconds: durationTest.second,minutes: durationTest.minute,hours: durationTest.day);

  }

  factory RunningTaskData.fromJson(Map<String, dynamic> json) => RunningTaskData(
    userTaskTimerId: json["UserTaskTimerID"],
    userId: json["UserID"],
    taskId: json["TaskID"],
    timerDate: json["TimerDate"] == null ? null : DateTime.parse(json["TimerDate"]),
    startTime: json["StartTime"] == null ? null : DateTime.parse(json["StartTime"]),
    title: json["Title"],
    status: json["Status"],
    priority: json["Priority"],
    projectId: json["ProjectID"],
    projectName: json["ProjectName"],
    projectLogo: json["ProjectLogo"],
  );

  Map<String, dynamic> toJson() => {
    "UserTaskTimerID": userTaskTimerId,
    "UserID": userId,
    "TaskID": taskId,
    "TimerDate": timerDate?.toIso8601String(),
    "StartTime": startTime?.toIso8601String(),
    "Title": title,
    "Status": status,
    "Priority": priority,
    "ProjectID": projectId,
    "ProjectName": projectName,
    "ProjectLogo": projectLogo,
  };

}



