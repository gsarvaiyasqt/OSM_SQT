import 'dart:convert';

class GerStatusAndPriorityResponseModel {
  int? statusCode;
  String? message;
  List<GerStatusAndPriorityData>? data;

  GerStatusAndPriorityResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GerStatusAndPriorityResponseModel.fromRawJson(String str) => GerStatusAndPriorityResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GerStatusAndPriorityResponseModel.fromJson(Map<String, dynamic> json) => GerStatusAndPriorityResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<GerStatusAndPriorityData>.from(json["data"]!.map((x) => GerStatusAndPriorityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GerStatusAndPriorityData {
  int? termId;
  String? term;
  String? category;
  int? isActive;
  int? isDefault;
  String? defaultValues;
  int? orderNo;


  GerStatusAndPriorityData({
    this.termId,
    this.term,
    this.category,
    this.isActive,
    this.isDefault,
    this.defaultValues,
    this.orderNo,
  });

  factory GerStatusAndPriorityData.fromRawJson(String str) => GerStatusAndPriorityData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GerStatusAndPriorityData.fromJson(Map<String, dynamic> json) => GerStatusAndPriorityData(
    termId: json["TermID"],
    term: json["Term"],
    category: json["Category"],
    isActive: json["IsActive"],
    isDefault: json["IsDefault"],
    defaultValues: json["DefaultValues"],
    orderNo: json["OrderNo"],

  );

  Map<String, dynamic> toJson() => {
    "TermID": termId,
    "Term": term,
    "Category": category,
    "IsActive": isActive,
    "IsDefault": isDefault,
    "DefaultValues": defaultValues,
    "OrderNo": orderNo,

  };
}
