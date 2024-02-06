// To parse this JSON data, do
//
//     final sendOtpResModel = sendOtpResModelFromJson(jsonString);

import 'dart:convert';

SendOtpResModel sendOtpResModelFromJson(String str) => SendOtpResModel.fromJson(json.decode(str));

String sendOtpResModelToJson(SendOtpResModel data) => json.encode(data.toJson());

class SendOtpResModel {
  int? statusCode;
  String? message;
  SendOtpData? data;

  SendOtpResModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory SendOtpResModel.fromJson(Map<String, dynamic> json) => SendOtpResModel(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : SendOtpData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class SendOtpData {
  int? otp;

  SendOtpData({
    this.otp,
  });

  factory SendOtpData.fromJson(Map<String, dynamic> json) => SendOtpData(
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
  };
}
