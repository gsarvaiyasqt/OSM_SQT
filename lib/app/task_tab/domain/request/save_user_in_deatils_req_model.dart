import 'dart:convert';

class SaveDataInDetailReqMode{

  List<SaveUserDataInDetailsData>? saveUserList;

  SaveDataInDetailReqMode({this.saveUserList});





}
class SaveUserDataInDetailsData {
  int? taskUserId;
  int? taskId;
  int? userId;
  int? projectId;
  bool? isActive;
  bool? isAssign;
  int? createdBy;
  String? name;

  SaveUserDataInDetailsData({
    this.taskUserId,
    this.taskId,
    this.userId,
    this.projectId,
    this.isActive,
    this.isAssign,
    this.createdBy,
    this.name,
  });

  factory SaveUserDataInDetailsData.fromRawJson(String str) => SaveUserDataInDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaveUserDataInDetailsData.fromJson(Map<String, dynamic> json) => SaveUserDataInDetailsData(
    taskUserId: json["taskUserID"],
    taskId: json["taskID"],
    userId: json["userID"],
    projectId: json["projectID"],
    isActive: json["isActive"],
    isAssign: json["isAssign"],
    createdBy: json["createdBy"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "taskUserID": taskUserId ?? 0,
    "taskID": taskId,
    "userID": userId,
    "projectID": projectId,
    "isActive": isActive,
    "isAssign": isAssign,
    "createdBy": createdBy,
    "name": name,
  };
}
