

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:osm_flutter/app/task_tab/domain/request/start_stop_task_req_model.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/base_res_model.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/get_running_task_res_model.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';

import '../../app/task_tab/domain/request/comment_save_req_data_model.dart';
import '../../app/task_tab/domain/request/create_task_req_model.dart';
import '../../app/task_tab/domain/request/get_recent_task_request_model.dart';
import '../../app/task_tab/domain/request/get_status_count.dart';
import '../../app/task_tab/domain/request/get_user_and_project_request_model.dart';
import '../../app/task_tab/domain/request/save_user_in_deatils_req_model.dart';
import '../../app/task_tab/domain/request/update_client_min_response_model.dart';
import '../../app/task_tab/domain/request/update_task_status_and_priority_request_model.dart';
import '../../app/task_tab/domain/request/update_timer_request_model.dart';
import '../../app/task_tab/domain/respones/GetListTaskDateWiseTimerAndUserTaskModel.dart';
import '../../app/task_tab/domain/respones/get_count_status_response_model.dart';
import '../../app/task_tab/domain/respones/get_create_task_response.dart';
import '../../app/task_tab/domain/respones/get_list_task_data_model.dart';
import '../../app/task_tab/domain/respones/get_recent_task_response_model.dart';
import '../../app/task_tab/domain/respones/get_status_and_priority_res_model.dart';
import '../../app/task_tab/domain/respones/get_sub_point_check_un_chack_response_model.dart';
import '../../app/task_tab/domain/respones/get_task_details_response_model.dart';
import '../../app/task_tab/domain/respones/get_user_and_project_response_model.dart';
import '../../app/task_tab/domain/respones/save_comment_response_data.dart';
import '../../app/task_tab/domain/respones/save_user_in_details_response_model.dart';
import '../../utils/utils.dart';

abstract class ITaskUseCases{
   Future<GetStatusCountResponseModel?> getCountStatusCount({GetStatusCountRequestModel? getStatusCountRequestModel});
   Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
   Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
   Future<GerStatusAndPriorityResponseModel?> getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType});
   Future<GetCreateTaskResponseModel?> getCreateTaskData({CreateTaskReqModel? createTasRequestModel});


   Future<BaseResModel?> startTask({StartStopTaskReqModel? startStopTaskReqModel});
   Future<BaseResModel?> stopTask({StartStopTaskReqModel? startStopTaskReqModel});
   Future<GetRunningTaskDetailsResModel?> getRunningTask();

   Future<GetTaskDetailsResponseModel?> getTaskDetailsData({required int? id});
   Future<GetSubPointCheckUnCheckResponseModel?> getCheckAndUnCheckSubPointData({required int? taskSubPointID,required bool? isDone});
   Future<BaseResModel?> updateTaskStatusAndPriorityData({required UpdateTaskStatusAndPriorityRequestModel? updateTaskStatusAndPriorityRequestModel});
   Future<BaseResModel?> deleteUserInTask({required String? name,required int? id});
   Future<SaveUserDetailsResponseModel?> saveUserInDetails({required SaveDataInDetailReqMode saveDataInDetailReqMode});
   Future<GetIdListTaskDetails?> getListTaskDetailsData({required int? taskId,required bool? isLog});
   Future<SaveCommentDataResponseModel?> saveCommentReqData({required CommentSaveReqData? commentSaveReqData});
   Future<BaseResModel?> deleteTaskCommentDetails({required int? id});
   Future<GetTaskDateWiseTimeResponseModel?> getTaskDateWiseTimeResponseModel({required int? projectId,required int? taskId});
   Future<BaseResModel?>updateTimerData({required UpdateTimerRequestModel updateTimerRequestModel});
   Future<BaseResModel?>updateClientTimer({required UpdateClientMinsResponseModel updateClientMinsResponseModel});
}

class TaskUseCases extends ITaskUseCases{

  @override
  Future<GetStatusCountResponseModel?> getCountStatusCount({GetStatusCountRequestModel? getStatusCountRequestModel}) async{

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.getstatuswisecount,data: getStatusCountRequestModel?.toJson()));

    return GetStatusCountResponseModel.fromJson(response);


  }

  @override
  Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel}) async{

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.getlistwithtimedata,data: recentTaskRequestModel?.toJson()));

    return RecentTaskResponseModel.fromJson(response);

  }

  @override
  Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel}) async{

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.projectGetList,data: getProjectAndAssignUserRequestModel?.toJson()));

    return GetProjectAndAssignUserResponseModel.fromJson(response);
  }

  @override
  Future<GerStatusAndPriorityResponseModel?> getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.projectTermGetList,data: {
      "category":getStatusAndPriorityType?.str
    }));
    return GerStatusAndPriorityResponseModel.fromJson(response);
  }

  @override
  Future<GetCreateTaskResponseModel?> getCreateTaskData({CreateTaskReqModel? createTasRequestModel}) async{


    Map<String,dynamic> map = {
      "TaskID": 0,
      "Title": createTasRequestModel?.title,
      "Details": createTasRequestModel?.details,
      "Status":createTasRequestModel?.status,
      "Priority":createTasRequestModel?.priority,
      "StartDate":createTasRequestModel?.startDate?.toIso8601String(),
      "EndDate": createTasRequestModel?.endDate?.toIso8601String(),
      "ProjectID":createTasRequestModel?.projectID,
    };
    
    final formData = FormData.fromMap(map);
    
    final userList = createTasRequestModel?.multipleTestAssignUser;
    final userTaskSubPointList = createTasRequestModel?.userTaskSubPointList;
    final docList = createTasRequestModel?.docList;

    if(userList != null){

      for(var i = 0; i < userList.length;i++){

        formData.fields.add(MapEntry("lstTaskUser[$i].UserID",userList[i].projectId.toString()));

      }


      
    }


    if(userTaskSubPointList != null){

      for(var i = 0; i < userTaskSubPointList.length;i++){

        if(userTaskSubPointList[i].title?.isNotEmpty == true){

          formData.fields.add(MapEntry("lstTaskSubPoint[$i].Title",userTaskSubPointList[i].title ?? ""));
          formData.fields.add(MapEntry("lstTaskSubPoint[$i].TaskSubPointID",0.toString()));

        }



      }

    }


    if(docList != null){

      for(var i = 0; i < docList.length;i++){

        formData.fields.add(MapEntry("lstDocuments[$i].DocName",docList[i].path.split("/").last ?? ""));
        formData.files.add(MapEntry("lstTaskSubPoint[$i].File",await MultipartFile.fromFile(docList[i].path ?? "",filename: docList[i].path.split("/").last)));

      }

    }

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.createTask,data: formData));

    return GetCreateTaskResponseModel.fromJson(response);


  }

  @override
  Future<BaseResModel> startTask({StartStopTaskReqModel? startStopTaskReqModel}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.startTask,data: startStopTaskReqModel?.toJson()));
    return BaseResModel.fromJson(response);
  }

  @override
  Future<BaseResModel> stopTask({StartStopTaskReqModel? startStopTaskReqModel}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.stopTask,data: startStopTaskReqModel?.toJson()));

    return BaseResModel.fromJson(response);
  }

  @override
  Future<GetRunningTaskDetailsResModel?> getRunningTask() async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.getRunningDetails));
    return GetRunningTaskDetailsResModel.fromJson(response);
  }
  
  @override
  Future<GetTaskDetailsResponseModel?> getTaskDetailsData({required int? id}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.taskDetails,data: {
      "id":id
    }));
    return GetTaskDetailsResponseModel.fromJson(response);
  }

  @override
  Future<GetSubPointCheckUnCheckResponseModel?> getCheckAndUnCheckSubPointData({required int? taskSubPointID, required bool? isDone}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.subPointCheckUnCheck,data: {
      "taskSubPointID":taskSubPointID,
      "isDone":isDone
    }));
    return GetSubPointCheckUnCheckResponseModel.fromJson(response);

  }

  @override
  Future<BaseResModel?> updateTaskStatusAndPriorityData({required UpdateTaskStatusAndPriorityRequestModel? updateTaskStatusAndPriorityRequestModel}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.taskUpdateField,data: updateTaskStatusAndPriorityRequestModel?.toJson()));
    return BaseResModel.fromJson(response);
  }

  @override
  Future<BaseResModel?> deleteUserInTask({required String? name, required int? id}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.deleteUser,data: {
      "name":name,
      "id": id
    }));
    return BaseResModel.fromJson(response);
  }

  @override
  Future<SaveUserDetailsResponseModel?> saveUserInDetails({required SaveDataInDetailReqMode saveDataInDetailReqMode}) async{

    final list = saveDataInDetailReqMode.saveUserList;

    List<dynamic> listData = [];






    if(list != null){

      for (var element in list) {

        listData.add(element.toJson());


      }


    }



    var test = jsonEncode(listData);

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.saveUserInDetail,data: test));
    return SaveUserDetailsResponseModel.fromJson(response);
  }

  @override
  Future<GetIdListTaskDetails?> getListTaskDetailsData({required int? taskId, required bool? isLog}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.getListByTaskId,data: {
      "taskID":taskId,
      "isLog":isLog
    }));

    return GetIdListTaskDetails.fromJson(response);

  }

  @override
  Future<SaveCommentDataResponseModel?> saveCommentReqData({required CommentSaveReqData? commentSaveReqData}) async{

    final fromData = FormData.fromMap(commentSaveReqData!.toJson());
   
    
    
    final list = commentSaveReqData.list;
    if(list != null){
      
      
      for(int i = 0; i < list.length;i++){

        fromData.files.add(MapEntry("lstDocuments[$i].file",await MultipartFile.fromFile("${commentSaveReqData.list?[i].path}",filename: commentSaveReqData.list?[i].path.split("/").last)));
        fromData.fields.add(MapEntry("lstDocuments[$i].docName",list[i].path.split("/").last));
      }
      
    }
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.taskLogDetailsSave,data: fromData));
    return SaveCommentDataResponseModel.fromJson(response);

  }

  @override
  Future<BaseResModel?> deleteTaskCommentDetails({required int? id}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.deleteCommentDetail,data: {
      "id":id
    }));
    return BaseResModel.fromJson(response);
  }

  @override
  Future<GetTaskDateWiseTimeResponseModel?> getTaskDateWiseTimeResponseModel({required int? projectId, required int? taskId}) async{
    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.getListTaskDateWiseTimeAndUserTaskTimer,data: {
      "projectID":projectId,
      "taskID":taskId
    }));
    return GetTaskDateWiseTimeResponseModel.fromJson(response);
  }

  @override
  Future<BaseResModel?> updateTimerData({required UpdateTimerRequestModel updateTimerRequestModel}) async{

    FormData formData = FormData.fromMap(updateTimerRequestModel.toMap());

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.updateDateAndTime,data: formData));
    return BaseResModel.fromJson(response);
  }

  @override
  Future<BaseResModel?> updateClientTimer({required UpdateClientMinsResponseModel updateClientMinsResponseModel}) async{

    FormData formData = FormData.fromMap(updateClientMinsResponseModel.toMap());

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.updateUserClientTime,data: formData));
    return BaseResModel.fromJson(response);
  }





}