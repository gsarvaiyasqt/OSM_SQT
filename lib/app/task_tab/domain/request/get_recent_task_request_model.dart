import 'dart:convert';

class RecentTaskRequestModel {
  String? title;
  String? status;
  String? priority;
  DateTime? startDate;
  DateTime? endDate;
  String? projectId;
  int? userId;
  int? associationId;
  String? associationType;

  RecentTaskRequestModel({
    this.title,
    this.status,
    this.priority,
    this.startDate,
    this.endDate,
    this.projectId,
    this.userId,
    this.associationId,
    this.associationType,
  });

  factory RecentTaskRequestModel.fromRawJson(String str) => RecentTaskRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentTaskRequestModel.fromJson(Map<String, dynamic> json) => RecentTaskRequestModel(
    title: json["title"],
    status: json["status"],
    priority: json["priority"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    projectId: json["projectID"],
    userId: json["userID"],
    associationId: json["associationID"],
    associationType: json["associationType"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "status": status,
    "priority": priority,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "projectID": projectId,
    "userID": userId,
    "associationID": associationId,
    "associationType": associationType,
  };
}
