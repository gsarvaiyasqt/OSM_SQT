

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';

import '../../app/task_tab/domain/request/get_recent_task_request_model.dart';
import '../../app/task_tab/domain/request/get_status_count.dart';
import '../../app/task_tab/domain/request/get_user_and_project_request_model.dart';
import '../../app/task_tab/domain/respones/get_count_status_response_model.dart';
import '../../app/task_tab/domain/respones/get_recent_task_response_model.dart';
import '../../app/task_tab/domain/respones/get_user_and_project_response_model.dart';

abstract class ITaskUseCases{
   Future<GetStatusCountResponseModel?> getCountStatusCount({GetStatusCountRequestModel? getStatusCountRequestModel});
   Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
   Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
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


}