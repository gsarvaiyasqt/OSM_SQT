import 'dart:convert';




class SaveUserDetailsResponseModel {
  int? statusCode;
  String? message;
  List<SaveUserDetailsDatum>? data;

  SaveUserDetailsResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory SaveUserDetailsResponseModel.fromRawJson(String str) => SaveUserDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveUserDetailsResponseModel.fromJson(Map<String, dynamic> json) => SaveUserDetailsResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SaveUserDetailsDatum>.from(json["data"]!.map((x) => SaveUserDetailsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SaveUserDetailsDatum {
  int? taskUserId;
  int? taskId;
  int? userId;
  int? projectId;
  bool? isActive;
  bool? isAssign;
  int? createdBy;
  DateTime? createdOn;

  SaveUserDetailsDatum({
    this.taskUserId,
    this.taskId,
    this.userId,
    this.projectId,
    this.isActive,
    this.isAssign,
    this.createdBy,
    this.createdOn,
  });

  factory SaveUserDetailsDatum.fromRawJson(String str) => SaveUserDetailsDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveUserDetailsDatum.fromJson(Map<String, dynamic> json) => SaveUserDetailsDatum(
    taskUserId: json["taskUserID"],
    taskId: json["taskID"],
    userId: json["userID"],
    projectId: json["projectID"],
    isActive: json["isActive"],
    isAssign: json["isAssign"],
    createdBy: json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
  );

  Map<String, dynamic> toJson() => {
    "taskUserID": taskUserId,
    "taskID": taskId,
    "userID": userId,
    "projectID": projectId,
    "isActive": isActive,
    "isAssign": isAssign,
    "createdBy": createdBy,
    "createdOn": createdOn?.toIso8601String(),
  };
}
