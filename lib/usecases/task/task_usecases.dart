

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';

import '../../app/task_tab/domain/request/create_task_req_model.dart';
import '../../app/task_tab/domain/request/get_recent_task_request_model.dart';
import '../../app/task_tab/domain/request/get_status_count.dart';
import '../../app/task_tab/domain/request/get_user_and_project_request_model.dart';
import '../../app/task_tab/domain/respones/get_count_status_response_model.dart';
import '../../app/task_tab/domain/respones/get_create_task_response.dart';
import '../../app/task_tab/domain/respones/get_recent_task_response_model.dart';
import '../../app/task_tab/domain/respones/get_status_and_priority_res_model.dart';
import '../../app/task_tab/domain/respones/get_user_and_project_response_model.dart';
import '../../utils/utils.dart';

abstract class ITaskUseCases{
   Future<GetStatusCountResponseModel?> getCountStatusCount({GetStatusCountRequestModel? getStatusCountRequestModel});
   Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
   Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
   Future<GerStatusAndPriorityResponseModel?> getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType});
   Future<GetCreateTaskResponseModel?> getCreateTaskData({CreateTaskReqModel? createTasRequestModel});
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
    
    final userList = createTasRequestModel?.userList;
    final userTaskSubPointList = createTasRequestModel?.userTaskSubPointList;
    final docList = createTasRequestModel?.docList;

    if(userList != null){

      for(var i = 0; i < userList.length;i++){

        formData.fields.add(MapEntry("lstTaskUser[$i].UserID",userList[i].userId.toString()));

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


}