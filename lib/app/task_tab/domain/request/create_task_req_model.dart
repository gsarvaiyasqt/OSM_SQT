
import 'dart:io';


class CreateTasRequestModel{
  String? projectName;
  int? projectId;
  String? assignInName;
  String? priority;
  List<String> multipleAssignUser = [];
  String? status;

  CreateTasRequestModel({this.projectName,this.projectId,this.assignInName,this.priority,this.status,required this.multipleAssignUser});
}

class CreateTaskReqModel{
  int? taskID;
  String? title;
  String? name;
  String? assignInName;
  String? details;
  String? status;
  String? priority;
  DateTime? startDate;
  DateTime? endDate;
  int? projectID;
  List<String> multipleAssignUser = [];
  List<File>? docList;
  List<UserTaskSubPointReqModel>? userTaskSubPointList;
  List<UserListReqModel>? userList;

  CreateTaskReqModel({this.priority,this.status,this.startDate,
    this.title,this.details,this.docList,this.endDate,
    this.projectID,this.taskID,this.userList,
    this.userTaskSubPointList,this.name,
    this.assignInName,
    required this.multipleAssignUser
  });

  // Map<String,dynamic> toJson(){
  //   return {
  //     "TaskID":taskID,
  //     "Title":title,
  //     "Details":details,
  //     "Status":status,
  //     "Priority":priority,
  //     "StartDate":startDate?.toIso8601String(),
  //     "EndDate":endDate?.toIso8601String(),
  //     "ProjectID":projectID,
  //     "lstTaskUser":userList == null ? [] : List<UserListReqModel>.from((userList ?? []).map((e) => e.toMap())),
  //     "lstTaskSubPoint":userTaskSubPointList == null ? [] : List<UserListReqModel>.from((userTaskSubPointList ?? []).map((e) => e.toMap())),
  //     // "lstDocuments":docList == null ? [] : List<CreateTaskDocumentReqModel>.from((docList ?? []).map((e) => e.toMap()))
  //   };
  // }

}
class CreateTaskDocumentReqModel{
  String? docName;
  File? file;

  CreateTaskDocumentReqModel({this.docName,this.file});

  Map<String,dynamic>toMap(){
    return {
      "docName": docName,
      "file": file,
    };
  }

}
class UserTaskSubPointReqModel{
  String? title;
  UserTaskSubPointReqModel({this.title});
  Map<String,dynamic>toMap(){
    return {
      "taskSubPointID": 0,
      "Title": title,
    };
  }

}
class UserListReqModel{
  String? userId;

  UserListReqModel({this.userId});
  Map<String,dynamic>toMap(){
    return {
      "userID":userId
    };
  }
}