import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/app/project_tab/repository/project_repository.dart';
import 'package:osm_flutter/app/project_tab/domain/dummy/project_list_model.dart';
import 'package:osm_flutter/app/project_tab/domain/request/project_get_list_req_model.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/get_user_and_project_response_model.dart';

abstract class IProjectProvider {
  Future getProjectList(
      {ProjectGetListRequestModel? projectGetListRequestModel});
}

class ProjectProvider extends BaseNotifier implements IProjectProvider {
  final IProjectRepository? projectRepository;

  ProjectProvider({this.projectRepository}) {
    _getProjectListResponse = AppResponse();
  }

  late AppResponse<GetProjectAndAssignUserResponseModel>_getProjectListResponse;
  AppResponse<GetProjectAndAssignUserResponseModel> get getProjectListResponse => _getProjectListResponse;

  List<ProjectListModel> projectListData = [];

  List<List<ProjectUser>> projectUserList = [];

  List<String> image = [];

  List<Demo> demoList = [];


  groupItemsByCategory(List<ProjectUser> projectUser) {
    return groupBy(projectUser, (item) => item.projectId);
  }

  @override
  Future getProjectList({ProjectGetListRequestModel? projectGetListRequestModel}) async {
    resIsLoading(_getProjectListResponse);

    try {
      final response = await projectRepository?.getProjectList(
          projectGetListRequestModel: projectGetListRequestModel);

      if (response?.statusCode != 1) {

        throw response?.message ?? "";

      } else {

        final projectUser = response?.data?.projectUser;

        final projectList = response?.data?.projectList;

        projectList?.forEach((pLElement) {

          final proUserList = projectUser?.where((e) => e.projectId == pLElement.projectId).toList();

          projectListData.add(ProjectListModel(
              projectName: pLElement.projectName,
              id: pLElement.projectId,
              profilePic: image,
              projectDate: DateFormat('dd-MM-yyyy').format(pLElement.startDate ?? DateTime.now()) ,
              taskCount: pLElement.allTaskCount.toString(),
              status: pLElement.status,
              projectImg: pLElement.projectLogo,
              technologies: pLElement.technologies,
              allTaskCount: pLElement.allTaskCount,
              closeTaskCount: pLElement.closedTaskCount,
              projectUserList: proUserList
          ));

        });


        resIsSuccess(_getProjectListResponse, response);
      }
    } catch (e) {

      resIsFailed(_getProjectListResponse, e);

      rethrow;

    }
  }
}

class Demo {
  String? profile;
  int? id;

  Demo({this.id, this.profile});
}
