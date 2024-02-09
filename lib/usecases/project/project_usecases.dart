import 'package:osm_flutter/app/project_tab/domain/request/project_get_list_req_model.dart';
import 'package:osm_flutter/server_configs/config.dart';
import 'package:osm_flutter/services/web_services.dart';
import '../../app/task_tab/domain/respones/get_user_and_project_response_model.dart';

abstract class IProjectUseCases{
  Future<GetProjectAndAssignUserResponseModel> getProjectList({ProjectGetListRequestModel? projectGetListRequestModel});
}

class ProjectUSeCases extends IProjectUseCases{
  @override
  Future<GetProjectAndAssignUserResponseModel> getProjectList({ProjectGetListRequestModel? projectGetListRequestModel}) async {

    final response = await WebService.instance.post(request: NetworkRequest(url: ServerConfig.projectGetList,data: projectGetListRequestModel?.toJson()));

    return GetProjectAndAssignUserResponseModel.fromJson(response);
  }

}