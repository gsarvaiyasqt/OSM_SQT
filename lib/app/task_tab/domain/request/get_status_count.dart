import 'dart:convert';

class GetStatusCountRequestModel {
  String? projectId;
  int? userId;
  int? associationId;
  String? associationType;

  GetStatusCountRequestModel({
    this.projectId,
    this.userId,
    this.associationId,
    this.associationType,
  });

  factory GetStatusCountRequestModel.fromRawJson(String str) => GetStatusCountRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetStatusCountRequestModel.fromJson(Map<String, dynamic> json) => GetStatusCountRequestModel(
    projectId: json["projectID"],
    userId: json["userID"],
    associationId: json["associationID"],
    associationType: json["associationType"],
  );

  Map<String, dynamic> toJson() => {
    "projectID": projectId ?? "",
    "userID": userId,
    "associationID": associationId,
    "associationType": associationType ?? "",
  };
}
