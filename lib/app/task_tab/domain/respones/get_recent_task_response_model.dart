import 'dart:convert';

class RecentTaskResponseModel {
  int? statusCode;
  String? message;
  RecentTaskData? data;

  RecentTaskResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory RecentTaskResponseModel.fromRawJson(String str) => RecentTaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentTaskResponseModel.fromJson(Map<String, dynamic> json) => RecentTaskResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : RecentTaskData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class RecentTaskData {
  List<TaskList>? taskList;
  List<TaskUserList>? taskUserList;
  List<dynamic>? runningTaskList;

  RecentTaskData({
    this.taskList,
    this.taskUserList,
    this.runningTaskList,
  });

  factory RecentTaskData.fromRawJson(String str) => RecentTaskData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentTaskData.fromJson(Map<String, dynamic> json) => RecentTaskData(
    taskList: json["taskList"] == null ? [] : List<TaskList>.from(json["taskList"]!.map((x) => TaskList.fromJson(x))),
    taskUserList: json["taskUserList"] == null ? [] : List<TaskUserList>.from(json["taskUserList"]!.map((x) => TaskUserList.fromJson(x))),
    runningTaskList: json["runningTaskList"] == null ? [] : List<dynamic>.from(json["runningTaskList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "taskList": taskList == null ? [] : List<dynamic>.from(taskList!.map((x) => x.toJson())),
    "taskUserList": taskUserList == null ? [] : List<dynamic>.from(taskUserList!.map((x) => x.toJson())),
    "runningTaskList": runningTaskList == null ? [] : List<dynamic>.from(runningTaskList!.map((x) => x)),
  };
}

class TaskList {
  int? rowNum;
  DateTime? dateRang;
  String? projectName;
  int? taskId;
  String? title;
  String? status;
  String? priority;
  DateTime? startDate;
  DateTime? endDate;
  int? projectId;
  int? createdBy;
  String? projectLogo;
  int? totalTimeInMinites;
  int? runningCount;
  int? isAssign;
  int? isTaskRunningByMe;

  TaskList({
    this.rowNum,
    this.dateRang,
    this.projectName,
    this.taskId,
    this.title,
    this.status,
    this.priority,
    this.startDate,
    this.endDate,
    this.projectId,
    this.createdBy,
    this.projectLogo,
    this.totalTimeInMinites,
    this.runningCount,
    this.isAssign,
    this.isTaskRunningByMe,
  });

  factory TaskList.fromRawJson(String str) => TaskList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    rowNum: json["row_num"],
    dateRang: json["DateRang"] == null ? null : DateTime.parse(json["DateRang"]),
    projectName: json["ProjectName"],
    taskId: json["TaskID"],
    title: json["Title"],
    status: json["Status"],
    priority: json["Priority"],
    startDate: json["StartDate"] == null ? null : DateTime.parse(json["StartDate"]),
    endDate: json["EndDate"] == null ? null : DateTime.parse(json["EndDate"]),
    projectId: json["ProjectID"],
    createdBy: json["CreatedBy"],
    projectLogo: json["ProjectLogo"],
    totalTimeInMinites: json["TotalTimeInMinites"],
    runningCount: json["RunningCount"],
    isAssign: json["IsAssign"],
    isTaskRunningByMe: json["IsTaskRunningByMe"],
  );

  Map<String, dynamic> toJson() => {
    "row_num": rowNum,
    "DateRang": dateRang?.toIso8601String(),
    "ProjectName": projectName,
    "TaskID": taskId,
    "Title": title,
    "Status": status,
    "Priority": priority,
    "StartDate": startDate?.toIso8601String(),
    "EndDate": endDate?.toIso8601String(),
    "ProjectID": projectId,
    "CreatedBy": createdBy,
    "ProjectLogo": projectLogo,
    "TotalTimeInMinites": totalTimeInMinites,
    "RunningCount": runningCount,
    "IsAssign": isAssign,
    "IsTaskRunningByMe": isTaskRunningByMe,
  };
}

class TaskUserList {
  int? taskId;
  int? userId;
  String? displayName;
  String? profilePic;
  int? isAssign;

  TaskUserList({
    this.taskId,
    this.userId,
    this.displayName,
    this.profilePic,
    this.isAssign,
  });

  factory TaskUserList.fromRawJson(String str) => TaskUserList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskUserList.fromJson(Map<String, dynamic> json) => TaskUserList(
    taskId: json["TaskID"],
    userId: json["UserID"],
    displayName: json["DisplayName"],
    profilePic: json["ProfilePic"],
    isAssign: json["IsAssign"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "UserID": userId,
    "DisplayName": displayName,
    "ProfilePic": profilePic,
    "IsAssign": isAssign,
  };
}
