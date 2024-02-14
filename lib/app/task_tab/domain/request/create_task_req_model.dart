
import 'dart:io';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';


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
  List<String>? multipleAssignUser;
  List<SearchModel>? multipleTestAssignUser;
  List<File>? docList;
  List<UserTaskSubPointReqModel>? userTaskSubPointList;
  List<UserListReqModel>? userList;

  CreateTaskReqModel({this.priority,this.status,this.startDate,
    this.title,this.details,this.docList,this.endDate,
    this.projectID,this.taskID,this.userList,
    this.userTaskSubPointList,this.name,
    this.multipleTestAssignUser,
    this.assignInName,
    this.multipleAssignUser
  });


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