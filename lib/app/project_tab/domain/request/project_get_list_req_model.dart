// To parse this JSON data, do
//
//     final projectGetListRequestModel = projectGetListRequestModelFromJson(jsonString);

import 'dart:convert';

ProjectGetListRequestModel projectGetListRequestModelFromJson(String str) => ProjectGetListRequestModel.fromJson(json.decode(str));

String projectGetListRequestModelToJson(ProjectGetListRequestModel data) => json.encode(data.toJson());

class ProjectGetListRequestModel {
  String? projectName;
  dynamic startDate;
  dynamic endDate;
  String? status;
  String? technologies;
  String? searchText;
  String? profilePicFile;

  ProjectGetListRequestModel({
    this.projectName,
    this.startDate,
    this.endDate,
    this.status,
    this.technologies,
    this.searchText,
    this.profilePicFile,
  });

  factory ProjectGetListRequestModel.fromJson(Map<String, dynamic> json) => ProjectGetListRequestModel(
    projectName: json["projectName"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    status: json["status"],
    technologies: json["technologies"],
    searchText: json["searchText"],
    profilePicFile: json["ProfilePicFile"],
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "startDate": startDate,
    "endDate": endDate,
    "status": status,
    "technologies": technologies,
    "searchText": searchText,
    "ProfilePicFile": profilePicFile,
  };
}
