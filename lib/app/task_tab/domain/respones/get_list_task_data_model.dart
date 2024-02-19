import 'dart:convert';

class GetIdListTaskDetails {
  int? statusCode;
  String? message;
  TaskListDetailsData? data;

  GetIdListTaskDetails({
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetIdListTaskDetails.fromRawJson(String str) => GetIdListTaskDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetIdListTaskDetails.fromJson(Map<String, dynamic> json) => GetIdListTaskDetails(
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? null : TaskListDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class TaskListDetailsData {
  List<TaskDetail>? taskDetails;
  List<Document>? documents;

  TaskListDetailsData({
    this.taskDetails,
    this.documents,
  });

  factory TaskListDetailsData.fromRawJson(String str) => TaskListDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskListDetailsData.fromJson(Map<String, dynamic> json) => TaskListDetailsData(
    taskDetails: json["taskDetails"] == null ? [] : List<TaskDetail>.from(json["taskDetails"]!.map((x) => TaskDetail.fromJson(x))),
    documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "taskDetails": taskDetails == null ? [] : List<dynamic>.from(taskDetails!.map((x) => x.toJson())),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class Document {
  int? documentId;
  String? docName;
  String? filePath;
  int? isActive;
  String? fileType;
  String? details;
  String? docType;
  int? associationId;
  String? associationType;
  int? createdBy;
  DateTime? createdOn;
  String? fileMimeType;
  double? sizeInMb;

  Document({
    this.documentId,
    this.docName,
    this.filePath,
    this.isActive,
    this.fileType,
    this.details,
    this.docType,
    this.associationId,
    this.associationType,
    this.createdBy,
    this.createdOn,
    this.fileMimeType,
    this.sizeInMb,
  });

  factory Document.fromRawJson(String str) => Document.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    documentId: json["DocumentID"],
    docName: json["DocName"],
    filePath: json["FilePath"],
    isActive: json["IsActive"],
    fileType: json["FileType"],
    details: json["Details"],
    docType: json["DocType"],
    associationId: json["AssociationID"],
    associationType: json["AssociationType"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    fileMimeType: json["FileMimeType"],
    sizeInMb: json["SizeInMB"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "DocumentID": documentId,
    "DocName": docName,
    "FilePath": filePath,
    "IsActive": isActive,
    "FileType": fileType,
    "Details": details,
    "DocType": docType,
    "AssociationID": associationId,
    "AssociationType": associationType,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "FileMimeType": fileMimeType,
    "SizeInMB": sizeInMb,
  };
}

class TaskDetail {
  int? taskLogDetailId;
  String? details;
  int? createdBy;
  DateTime? createdOn;
  String? displayName;
  String? profilePic;
  List<Document>? documents;

  TaskDetail({
    this.taskLogDetailId,
    this.details,
    this.createdBy,
    this.createdOn,
    this.displayName,
    this.profilePic,
    this.documents
  });

  factory TaskDetail.fromRawJson(String str) => TaskDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskDetail.fromJson(Map<String, dynamic> json) => TaskDetail(
    taskLogDetailId: json["TaskLogDetailID"],
    details: json["Details"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    displayName: json["DisplayName"],
    profilePic: json["ProfilePic"],


  );

  Map<String, dynamic> toJson() => {
    "TaskLogDetailID": taskLogDetailId,
    "Details": details,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "DisplayName": displayName,
    "ProfilePic": profilePic,
  };
}
