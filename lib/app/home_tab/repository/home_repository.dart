

import '../../../usecases/home/home_usecases.dart';
import '../../task_tab/domain/request/get_recent_task_request_model.dart';
import '../../task_tab/domain/request/get_status_count.dart';
import '../../task_tab/domain/request/get_user_and_project_request_model.dart';
import '../../task_tab/domain/respones/get_count_status_response_model.dart';
import '../../task_tab/domain/respones/get_recent_task_response_model.dart';
import '../../task_tab/domain/respones/get_user_and_project_response_model.dart';

abstract class IHomeRepository{

  Future<GetStatusCountResponseModel?> getCountStatusCount({required GetStatusCountRequestModel? getStatusCountRequestModel});

  Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});

  Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});

}

class HomeRepository extends IHomeRepository{

  final IHomeUseCases? homeUseCases;

  HomeRepository({this.homeUseCases});

  @override
  Future<GetStatusCountResponseModel?> getCountStatusCount({required GetStatusCountRequestModel? getStatusCountRequestModel}) async{
    return await homeUseCases?.getCountStatusCount(getStatusCountRequestModel: getStatusCountRequestModel);
  }

  @override
  Future<RecentTaskResponseModel?> getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel}) async{
    return await homeUseCases?.getHomeTaskListData(recentTaskRequestModel: recentTaskRequestModel);
  }

  @override
  Future<GetProjectAndAssignUserResponseModel?> getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel}) async{

    return await homeUseCases?.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: getProjectAndAssignUserRequestModel);
  }

}