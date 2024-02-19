import 'dart:io';

class CommentSaveReqData{
  int? taskId;
  int? projectId;
  int? details;
  int? taskLogDetailId;
  List<CommentSaveDocumentReqData>? list;
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

class CommentSaveDocumentReqData{

  String? docName;
  File? file;
  String? orderDetail;
  String? docType;

  CommentSaveDocumentReqData({this.file,this.docName,this.docType,this.orderDetail});




}