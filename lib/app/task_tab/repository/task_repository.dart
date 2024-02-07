import 'package:osm_flutter/app/auth/domain/response/login_res_model.dart';
import 'package:osm_flutter/usecases/auth/auth_usecases.dart';

import '../../../usecases/task/task_usecases.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/request/get_status_count.dart';
import '../domain/request/get_user_and_project_request_model.dart';
import '../domain/respones/get_count_status_response_model.dart';
import '../domain/respones/get_recent_task_response_model.dart';
import '../domain/respones/get_user_and_project_response_model.dart';

abstract class ITaskRepository{
  Future<GetStatusCountResponseModel?> getCountStatusCount({required GetStatusCountRequestModel? getStatusCountRequestModel});
  Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
  Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
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


}