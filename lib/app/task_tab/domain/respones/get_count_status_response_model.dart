import 'dart:convert';

class GetStatusCountResponseModel {
  int? statusCode;
  String? message;
  List<CountStatusData>? data;

  GetStatusCountResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetStatusCountResponseModel.fromRawJson(String str) => GetStatusCountResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetStatusCountResponseModel.fromJson(Map<String, dynamic> json) => GetStatusCountResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CountStatusData>.from(json["data"]!.map((x) => CountStatusData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CountStatusData {
  String? status;
  int? taskCount;

  CountStatusData({
    this.status,
    this.taskCount,
  });

  factory CountStatusData.fromRawJson(String str) => CountStatusData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountStatusData.fromJson(Map<String, dynamic> json) => CountStatusData(
    status: json["Status"],
    taskCount: json["TaskCount"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "TaskCount": taskCount,
  };
}
