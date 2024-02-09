import 'dart:convert';

class GetProjectAndAssignUserResponseModel {
  int? statusCode;
  String? message;
  GetProjectAndAssignUserData? data;

  GetProjectAndAssignUserResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetProjectAndAssignUserResponseModel.fromRawJson(String str) => GetProjectAndAssignUserResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProjectAndAssignUserResponseModel.fromJson(Map<String, dynamic> json) => GetProjectAndAssignUserResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : GetProjectAndAssignUserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class GetProjectAndAssignUserData {
  List<ProjectList>? projectList;
  List<ProjectUser>? projectUser;

  GetProjectAndAssignUserData({
    this.projectList,
    this.projectUser,
  });

  factory GetProjectAndAssignUserData.fromRawJson(String str) => GetProjectAndAssignUserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProjectAndAssignUserData.fromJson(Map<String, dynamic> json) => GetProjectAndAssignUserData(
    projectList: json["projectList"] == null ? [] : List<ProjectList>.from(json["projectList"]!.map((x) => ProjectList.fromJson(x))),
    projectUser: json["projectUser"] == null ? [] : List<ProjectUser>.from(json["projectUser"]!.map((x) => ProjectUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "projectList": projectList == null ? [] : List<dynamic>.from(projectList!.map((x) => x.toJson())),
    "projectUser": projectUser == null ? [] : List<dynamic>.from(projectUser!.map((x) => x.toJson())),
  };
}

class ProjectList {
  int? projectId;
  String? projectName;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? technologies;
  int? isFixCost;
  dynamic noOfUser;
  int? clientId;
  String? projectLogo;
  int? allTaskCount;
  int? closedTaskCount;

  ProjectList({
    this.projectId,
    this.projectName,
    this.startDate,
    this.endDate,
    this.status,
    this.technologies,
    this.isFixCost,
    this.noOfUser,
    this.clientId,
    this.projectLogo,
    this.allTaskCount,
    this.closedTaskCount,
  });

  factory ProjectList.fromRawJson(String str) => ProjectList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
    projectId: json["ProjectID"],
    projectName: json["ProjectName"],
    startDate: json["StartDate"] == null ? null : DateTime.parse(json["StartDate"]),
    endDate: json["EndDate"] == null ? null : DateTime.parse(json["EndDate"]),
    status: json["Status"],
    technologies: json["Technologies"],
    isFixCost: json["IsFixCost"],
    noOfUser: json["NoOfUser"],
    clientId: json["ClientID"],
    projectLogo: json["ProjectLogo"],
    allTaskCount: json["AllTaskCount"],
    closedTaskCount: json["ClosedTaskCount"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectID": projectId,
    "ProjectName": projectName,
    "StartDate": startDate?.toIso8601String(),
    "EndDate": endDate?.toIso8601String(),
    "Status": status,
    "Technologies": technologies,
    "IsFixCost": isFixCost,
    "NoOfUser": noOfUser,
    "ClientID": clientId,
    "ProjectLogo": projectLogo,
    "AllTaskCount": allTaskCount,
    "ClosedTaskCount": closedTaskCount,
  };
}

class ProjectUser {
  int? projectId;
  int? projectUserId;
  int? userId;
  String? technologies;
  int? isManager;
  int? isTeamLead;
  int? projectRoleId;
  String? displayName;
  String? profilePic;
  String? roleName;

  ProjectUser({
    this.projectId,
    this.projectUserId,
    this.technologies,
    this.userId,
    this.isManager,
    this.isTeamLead,
    this.projectRoleId,
    this.displayName,
    this.profilePic,
    this.roleName,
  });

  factory ProjectUser.fromRawJson(String str) => ProjectUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProjectUser.fromJson(Map<String, dynamic> json) => ProjectUser(
    projectId: json["ProjectID"],
    projectUserId: json["ProjectUserID"],
    userId: json["UserID"],
    isManager: json["IsManager"],
    technologies: json["Technologies"],
    isTeamLead: json["IsTeamLead"],
    projectRoleId: json["ProjectRoleID"],
    displayName: json["DisplayName"],
    profilePic: json["ProfilePic"],
    roleName: json["RoleName"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectID": projectId,
    "ProjectUserID": projectUserId,
    "UserID": userId,
    "IsManager": isManager,
    "IsTeamLead": isTeamLead,
    "ProjectRoleID": projectRoleId,
    "DisplayName": displayName,
    "ProfilePic": profilePic,
    "RoleName": roleName,
  };
}

enum RoleName {
  PROJECT_MEMBER,
  TEAM_LEADER
}

final roleNameValues = EnumValues({
  "Project Member": RoleName.PROJECT_MEMBER,
  "Team Leader": RoleName.TEAM_LEADER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
