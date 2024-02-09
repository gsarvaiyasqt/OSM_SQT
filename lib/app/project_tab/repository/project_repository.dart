
import 'package:osm_flutter/usecases/project/project_usecases.dart';

import '../../task_tab/domain/respones/get_user_and_project_response_model.dart';
import '../domain/request/project_get_list_req_model.dart';

abstract class IProjectRepository{
  Future<GetProjectAndAssignUserResponseModel?> getProjectList({ProjectGetListRequestModel? projectGetListRequestModel});
}

class ProjectRepository extends IProjectRepository{

  final IProjectUseCases? projectUseCases;

  ProjectRepository({this.projectUseCases});


  @override
  Future<GetProjectAndAssignUserResponseModel?> getProjectList({ProjectGetListRequestModel? projectGetListRequestModel}) async {

    return await projectUseCases?.getProjectList(projectGetListRequestModel: projectGetListRequestModel);
  }
}

