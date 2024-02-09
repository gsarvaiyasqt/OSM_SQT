import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/project_tab/domain/dummy/project_list_model.dart';
import 'package:osm_flutter/app/project_tab/domain/request/project_get_list_req_model.dart';
import 'package:osm_flutter/app/project_tab/repository/project_repository.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/get_user_and_project_response_model.dart';
import 'package:osm_flutter/base/base.dart';

abstract class IProjectProvider {
  Future getProjectList(
      {ProjectGetListRequestModel? projectGetListRequestModel});
}

class ProjectProvider extends BaseNotifier implements IProjectProvider {
  final IProjectRepository? projectRepository;

  ProjectProvider({this.projectRepository}) {
    _getProjectListResponse = AppResponse();
  }

  late AppResponse<GetProjectAndAssignUserResponseModel>
      _getProjectListResponse;
  AppResponse<GetProjectAndAssignUserResponseModel>
      get getProjectListResponse => _getProjectListResponse;

  List<ProjectListModel> projectListData = [];

  List<List<ProjectUser>> projectUserList = [];

  List<String> image = [];

  List<Demo> demoList = [];


  groupItemsByCategory(List<ProjectUser> projectUser) {
    return groupBy(projectUser, (item) => item.projectId);
  }

  @override
  Future getProjectList(
      {ProjectGetListRequestModel? projectGetListRequestModel}) async {
    resIsLoading(_getProjectListResponse);

    try {
      final response = await projectRepository?.getProjectList(
          projectGetListRequestModel: projectGetListRequestModel);

      if (response?.statusCode != 1) {

        throw response?.message ?? "";

      } else {

        final projectUser = response?.data?.projectUser;

        final projectList = response?.data?.projectList;

        Map<int?,List<ProjectUser>> recentTaskMapData = groupItemsByCategory(projectUser!);

        recentTaskMapData.forEach((key, value) {
          final val = value;
          projectUserList.add(val);
        });

        projectList?.forEach((pLElement) {

          print("${pLElement.projectId} =====  check this projectID");

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
              closeTaskCount: pLElement.closedTaskCount
          ));

        });

        for (var projectList in projectListData) {

          projectUserList.forEach((element) {

            final userList = element.where((element) => element.projectId == projectList.id).toList();

            print("${userList} ====  check this userlist");
          });

        }


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
