// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  int? statusCode;
  String? message;
  Data? data;

  LoginResponseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<UserDatum>? userData;
  List<RoleDatum>? roleData;
  String? accesstoken;

  Data({
    this.userData,
    this.roleData,
    this.accesstoken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: json["userData"] == null ? [] : List<UserDatum>.from(json["userData"]!.map((x) => UserDatum.fromJson(x))),
    roleData: json["roleData"] == null ? [] : List<RoleDatum>.from(json["roleData"]!.map((x) => RoleDatum.fromJson(x))),
    accesstoken: json["accesstoken"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData == null ? [] : List<dynamic>.from(userData!.map((x) => x.toJson())),
    "roleData": roleData == null ? [] : List<dynamic>.from(roleData!.map((x) => x.toJson())),
    "accesstoken": accesstoken,
  };
}

class RoleDatum {
  int? rightId;
  String? rightName;
  String? menuName;
  int? isView;
  int? isCreate;
  int? isUpdate;
  int? isDelete;
  int? isDownload;

  RoleDatum({
    this.rightId,
    this.rightName,
    this.menuName,
    this.isView,
    this.isCreate,
    this.isUpdate,
    this.isDelete,
    this.isDownload,
  });

  factory RoleDatum.fromJson(Map<String, dynamic> json) => RoleDatum(
    rightId: json["RightID"],
    rightName: json["RightName"],
    menuName: json["MenuName"],
    isView: json["IsView"],
    isCreate: json["IsCreate"],
    isUpdate: json["IsUpdate"],
    isDelete: json["IsDelete"],
    isDownload: json["IsDownload"],
  );

  Map<String, dynamic> toJson() => {
    "RightID": rightId,
    "RightName": rightName,
    "MenuName": menuName,
    "IsView": isView,
    "IsCreate": isCreate,
    "IsUpdate": isUpdate,
    "IsDelete": isDelete,
    "IsDownload": isDownload,
  };
}

class UserDatum {
  int? userId;
  String? displayName;
  int? associationId;
  String? associationType;
  String? profilePic;

  UserDatum({
    this.userId,
    this.displayName,
    this.associationId,
    this.associationType,
    this.profilePic,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    userId: json["UserID"],
    displayName: json["DisplayName"],
    associationId: json["AssociationID"],
    associationType: json["AssociationType"],
    profilePic: json["ProfilePic"],
  );

  Map<String, dynamic> toJson() => {
    "UserID": userId,
    "DisplayName": displayName,
    "AssociationID": associationId,
    "AssociationType": associationType,
    "ProfilePic": profilePic,
  };
}
