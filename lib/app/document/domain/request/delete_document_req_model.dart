import 'dart:convert';

class DeleteDocumentRequestModel {
  int? id;
  int? otherId;
  String? otherIdType;
  String? requestFrom;

  DeleteDocumentRequestModel({
    this.id,
    this.otherId,
    this.otherIdType,
    this.requestFrom,
  });

  factory DeleteDocumentRequestModel.fromRawJson(String str) => DeleteDocumentRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteDocumentRequestModel.fromJson(Map<String, dynamic> json) => DeleteDocumentRequestModel(
    id: json["id"],
    otherId: json["OtherID"],
    otherIdType: json["OtherIDType"],
    requestFrom: json["requestFrom"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "OtherID": otherId,
    "OtherIDType": otherIdType,
    "requestFrom": requestFrom,
  };
}
