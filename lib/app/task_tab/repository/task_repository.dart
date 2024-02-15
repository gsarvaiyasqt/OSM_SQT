import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/usecases/auth/auth_usecases.dart';

import '../../../usecases/task/task_usecases.dart';
import '../../../utils/utils.dart';
import '../domain/request/create_task_req_model.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/request/get_status_count.dart';
import '../domain/request/get_user_and_project_request_model.dart';
import '../domain/request/start_stop_task_req_model.dart';
import '../domain/respones/base_res_model.dart';
import '../domain/respones/get_count_status_response_model.dart';
import '../domain/respones/get_create_task_response.dart';
import '../domain/respones/get_recent_task_response_model.dart';
import '../domain/respones/get_running_task_res_model.dart';
import '../domain/respones/get_status_and_priority_res_model.dart';
import '../domain/respones/get_sub_point_check_un_chack_response_model.dart';
import '../domain/respones/get_task_details_response_model.dart';
import '../domain/respones/get_user_and_project_response_model.dart';

abstract class ITaskRepository{
  Future<GetStatusCountResponseModel?> getCountStatusCount({required GetStatusCountRequestModel? getStatusCountRequestModel});
  Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
  Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
  Future<GerStatusAndPriorityResponseModel?> getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType});
  Future<GetCreateTaskResponseModel?> getCreateTaskData({CreateTaskReqModel? createTasRequestModel});

  Future<BaseResModel?> startTask({StartStopTaskReqModel? startStopTaskReqModel});
  Future<BaseResModel?> stopTask({StartStopTaskReqModel? startStopTaskReqModel});
  Future<GetRunningTaskDetailsResModel?> getRunningTask();

  Future<GetSubPointCheckUnCheckResponseModel?> getCheckAndUnCheckSubPointData({required int? taskSubPointID,required bool? isDone});
  Future<GetTaskDetailsResponseModel?> getTaskDetailsData({required int? id});
}

class TaskRepository extends ITaskRepository{

  final ITaskUseCases? taskUseCases;


  TaskRepository({this.taskUseCases});

  @override
  Future<GetStatusCountResponseModel?> getCountStatusCount({required GetStatusCountRequestModel? getStatusCountRequestModel}) async{
    return await taskUseCases?.getCountStatusCount(getStatusCountRequestModel: getStatusCountRequestModel);
  }

  @override
  Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel}) async{
    return await taskUseCases?.getRecentTaskListData(recentTaskRequestModel: recentTaskRequestModel);
  }

  @override
  Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel}) async{
    return await taskUseCases?.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: getProjectAndAssignUserRequestModel);
  }

  @override
  Future<GerStatusAndPriorityResponseModel?> getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType}) async{
    return await taskUseCases?.getStatusAndPriorityTerm(getStatusAndPriorityType: getStatusAndPriorityType);
  }

  @override
  Future<GetCreateTaskResponseModel?> getCreateTaskData({CreateTaskReqModel? createTasRequestModel}) async{
    return await taskUseCases?.getCreateTaskData(createTasRequestModel: createTasRequestModel);
  }

  @override

  Future<BaseResModel?> startTask({StartStopTaskReqModel? startStopTaskReqModel}) async{
    return await taskUseCases?.startTask(startStopTaskReqModel: startStopTaskReqModel);
  }

  @override
  Future<BaseResModel?> stopTask({StartStopTaskReqModel? startStopTaskReqModel}) async{
    return await taskUseCases?.stopTask(startStopTaskReqModel: startStopTaskReqModel);
  }

  Future<GetTaskDetailsResponseModel?> getTaskDetailsData({required int? id}) async{
    return await taskUseCases?.getTaskDetailsData(id: id);
  }

  @override
  Future<GetSubPointCheckUnCheckResponseModel?> getCheckAndUnCheckSubPointData({required int? taskSubPointID, required bool? isDone}) async{
    return await taskUseCases?.getCheckAndUnCheckSubPointData(taskSubPointID: taskSubPointID, isDone: isDone);
  }



  @override
  Future<GetRunningTaskDetailsResModel?> getRunningTask() async{
    return await taskUseCases?.getRunningTask();
  }
}