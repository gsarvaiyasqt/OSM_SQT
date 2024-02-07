import 'dart:convert';

class GetProjectAndAssignUserRequestModel {
  String? projectName;
  String? status;
  DateTime? startDate;
  DateTime? endDate;
  String? technologies;
  String? searchText;
  int? projectId;

  GetProjectAndAssignUserRequestModel({
    this.projectName,
    this.status,
    this.startDate,
    this.endDate,
    this.technologies,
    this.searchText,
    this.projectId
  });

  factory GetProjectAndAssignUserRequestModel.fromRawJson(String str) => GetProjectAndAssignUserRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProjectAndAssignUserRequestModel.fromJson(Map<String, dynamic> json) => GetProjectAndAssignUserRequestModel(
    projectName: json["ProjectName"],
    status: json["Status"],
    startDate: json["StartDate"],
    endDate: json["EndDate"],
    technologies: json["Technologies"],
    searchText: json["SearchText"],
  );

  Map<String, dynamic> toJson() => {
    "ProjectName": projectName,
    "Status": status,
    "StartDate": startDate?.toIso8601String(),
    "EndDate": endDate?.toIso8601String(),
    "Technologies": technologies,
    "SearchText": searchText,
  };
}
