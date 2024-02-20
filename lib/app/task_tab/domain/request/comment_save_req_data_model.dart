import 'dart:io';

class CommentSaveReqData{
  int? taskId;
  int? projectId;
  String? details;
  int? taskLogDetailId;
  List<File>? list;
  CommentSaveReqData({this.taskLogDetailId,this.details,this.taskId,this.projectId,this.list});
  Map<String,dynamic> toJson(){
    return {
      "ProjectID":projectId,
      "TaskID":taskId,
      "Details":details,
      "TaskLogDetailID":taskLogDetailId
    };
  }

}

