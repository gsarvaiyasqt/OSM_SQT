import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:osm_flutter/base/base.dart';
import '../domain/request/save_user_in_deatils_req_model.dart';
import '../domain/request/search_model.dart';
import 'package:osm_flutter/utils/utils.dart';
import '../domain/request/create_task_req_model.dart';
import '../domain/request/update_task_status_and_priority_request_model.dart';
import '../domain/respones/base_res_model.dart';
import '../domain/request/start_stop_task_req_model.dart';
import '../domain/respones/get_create_task_response.dart';
import '../../auth/domain/dummy/create_task_response.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/respones/get_recent_task_response_model.dart';
import '../domain/request/get_user_and_project_request_model.dart';
import '../domain/respones/get_running_task_res_model.dart';
import '../domain/respones/get_status_and_priority_res_model.dart';
import '../domain/respones/get_sub_point_check_un_chack_response_model.dart';
import '../domain/respones/get_task_details_response_model.dart';
import '../domain/respones/get_user_and_project_response_model.dart';
import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';

import '../domain/respones/save_user_in_details_response_model.dart';
import '../domain/ui_state/update_task_status_priority_ui_state.dart';

abstract class ITaskProvider {
  Future getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
  Future getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
  Future getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType});
  Future getCreateTaskData();


  Future startTask({StartStopTaskReqModel? startStopTaskReqModel});
  Future stopTask({StartStopTaskReqModel? startStopTaskReqModel});

  Future getRunningTask();
  
  Future getTaskDetailsData({required int? id});
  Future getCheckAndUnCheckSubPointData({required int? taskSubPointID,required bool? isDone});
  Future updateTaskStatusAndPriorityData();
  Future deleteUserInTask({required String? name,required int? id});
  Future saveUserInDetails({required SaveDataInDetailReqMode saveDataInDetailReqMode});

}

class TaskProvider extends BaseNotifier implements ITaskProvider{


  final ITaskRepository? taskRepository;


  TaskProvider({this.taskRepository}){
    _resentTaskResponse = AppResponse.loading("");
    _getProjectAndUserResponse = AppResponse.loading("");
    _getGerStatusAndPriorityResponse = AppResponse.loading("");
    _getGetCreateTaskResponse = AppResponse();
    _startTaskResponse = AppResponse();
    _stopTaskResponse = AppResponse();
    _getRunningTaskResponse = AppResponse();
    _getTaskDetailsResponse = AppResponse();
    _getSubPointCheckUnCheckResponse = AppResponse();
    _getUpdateStatusAndPriorityResponse = AppResponse();
    _deleteUserInTaskResponse = AppResponse();
    _saveUserDetailsResponse = AppResponse();
  }

  bool isLoading = false;



  late AppResponse<RecentTaskResponseModel> _resentTaskResponse;
  AppResponse<RecentTaskResponseModel> get resentTaskResponse => _resentTaskResponse;

  late AppResponse<GetProjectAndAssignUserResponseModel> _getProjectAndUserResponse;
  AppResponse<GetProjectAndAssignUserResponseModel> get getProjectAndUserResponse => _getProjectAndUserResponse;

  late AppResponse<GerStatusAndPriorityResponseModel> _getGerStatusAndPriorityResponse;
  AppResponse<GerStatusAndPriorityResponseModel> get getGerStatusAndPriorityResponse => _getGerStatusAndPriorityResponse;

  late AppResponse<GetCreateTaskResponseModel> _getGetCreateTaskResponse;
  AppResponse<GetCreateTaskResponseModel> get getGetCreateTaskResponse => _getGetCreateTaskResponse;

  late AppResponse<BaseResModel> _startTaskResponse;
  AppResponse<BaseResModel> get startTaskResponse => _startTaskResponse;

  late AppResponse<BaseResModel> _stopTaskResponse;
  AppResponse<BaseResModel> get stopTaskResponse => _stopTaskResponse;

  late AppResponse<GetRunningTaskDetailsResModel> _getRunningTaskResponse;
  AppResponse<GetRunningTaskDetailsResModel> get getRunningTaskResponse => _getRunningTaskResponse;
  
  late AppResponse<GetTaskDetailsResponseModel> _getTaskDetailsResponse;
  AppResponse<GetTaskDetailsResponseModel> get getTaskDetailsResponse => _getTaskDetailsResponse;


  late AppResponse<GetSubPointCheckUnCheckResponseModel> _getSubPointCheckUnCheckResponse;
  AppResponse<GetSubPointCheckUnCheckResponseModel> get getSubPointCheckUnCheckResponse => _getSubPointCheckUnCheckResponse;


  late AppResponse<BaseResModel> _getUpdateStatusAndPriorityResponse;
  AppResponse<BaseResModel> get getUpdateStatusAndPriorityResponse => _getUpdateStatusAndPriorityResponse;

  late AppResponse<BaseResModel> _deleteUserInTaskResponse;
  AppResponse<BaseResModel> get deleteUserInTaskResponse => _deleteUserInTaskResponse;


  late AppResponse<SaveUserDetailsResponseModel> _saveUserDetailsResponse;
  AppResponse<SaveUserDetailsResponseModel> get saveUserDetailsResponse => _saveUserDetailsResponse;

  UpdateTaskStatusPriorityUiState updateTaskStatusPriorityUiState = UpdateTaskStatusPriorityUiState();

  List<SearchModel> list = [];

  int? todayCount,comp,leave;

  List<SearchModel> projectUserList = [];

  CreateTaskReqModel createTaskReqModel = CreateTaskReqModel(
    multipleAssignUser: [],
    userList: [],
    userTaskSubPointList: [],
    docList: [],
    multipleTestAssignUser: []
  );

  List<CreateTaskListModel> listData = [];

  @override
  Future getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel}) async{

    resIsLoading(_resentTaskResponse);

    try {

      final response = await taskRepository?.getRecentTaskListData(recentTaskRequestModel: recentTaskRequestModel);

      if(response?.statusCode != 1){

      throw response?.message ?? "";

      }else{

        final list = response?.data?.taskList;

        if(list != null){

          list.sort((a, b) => a.dateRang!.compareTo(b.dateRang!));

          Map<DateTime?,List<TaskList>> recentTaskMapData  =  groupItemsByCategory(list);

          listData = [];

          recentTaskMapData.forEach((key, value) {

            var isDate = "";

            if(key?.day == DateTime.now().day){

              isDate = "Today";

            }else if(key?.day == (DateTime.now().day - 1)){

              isDate = "Yesterday";

            }else{

              isDate = DateFormat("d MMM yyyy").format(key!);

            }

            final taskValueList = value;

            List listVal = taskValueList.map((e) => e.totalTimeInMinites!).toList();

            double sum = listVal.fold(0, (p, c) => p + c);

            final hourConvert = formattedTime(timeInSecond: sum.toInt());

            listData.add(CreateTaskListModel(date: isDate,testList: value,time: hourConvert));

          });

        }

        resIsSuccess(_resentTaskResponse,response);

      }

    } catch (e) {
      resIsFailed(_resentTaskResponse, e);
      rethrow ;
    }


  }


  groupItemsByCategory(List<TaskList> taskList) {
    return groupBy(taskList, (item) => item.dateRang);
  }

  @override
  Future getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel}) async{

    resIsLoading(_getProjectAndUserResponse);


       await isUpdateLoading(isLoading: true);


        try {


          final response = await taskRepository?.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: getProjectAndAssignUserRequestModel);


          if(response?.statusCode != 1){

            throw response?.message ?? "";

          }else{

            if(getProjectAndAssignUserRequestModel?.projectId != null){

              response?.data?.projectUser?.where((wElement) => wElement.projectId == getProjectAndAssignUserRequestModel?.projectId).forEach((element) {

                list.add(SearchModel(name: element.displayName,projectId: element.userId));

              });

            }

            await isUpdateLoading(isLoading: false);


           resIsSuccess(_getProjectAndUserResponse,response);


          }



        } catch (e) {
          resIsFailed(_getProjectAndUserResponse, e);
          await isUpdateLoading(isLoading: false);
          rethrow;

        }


  }
  
  Future updateProjectAssignList(List<ProjectUser>? assignList) async {
    
    if(assignList != null){
      for(var element in assignList){
        list.add(SearchModel(name: element.displayName));
      }
      
    }
    notifyListeners();
  }
  

  Future updateSearchList(List<ProjectList>? projectList)async{

    if(projectList != null){

      for (var element in projectList) {

        list.add(SearchModel(name: element.projectName,projectId: element.projectId));

      }

    }
    notifyListeners();

  }


  @override
  Future getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType}) async{

    try {

      resIsLoading(_getGerStatusAndPriorityResponse);

      await isUpdateLoading(isLoading: true);

      final response = await taskRepository?.getStatusAndPriorityTerm(getStatusAndPriorityType: getStatusAndPriorityType);

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        response?.data?.forEach((element) {

          list.add(SearchModel(name: element.defaultValues,projectId: element.termId));

        });

        resIsSuccess(_getGerStatusAndPriorityResponse,response);

        await isUpdateLoading(isLoading: false);
      }


    } catch (e) {
      await isUpdateLoading(isLoading: false);
      resIsFailed(_getGerStatusAndPriorityResponse, e);
      rethrow;

    }
  }

  @override
  Future getCreateTaskData() async{


    if(createTaskReqModel.name == null && createTaskReqModel.projectID == null){

      throw "Please select project name";

    }
    if(createTaskReqModel.title == null){

      throw "Please write a title";

    }
    if(createTaskReqModel.priority == null){

      throw "Please select priority";

    }
    if(createTaskReqModel.status == null){

      throw "Please select status";

    }

    try {


      resIsLoading(_getGetCreateTaskResponse);


      final response = await taskRepository?.getCreateTaskData(createTasRequestModel: createTaskReqModel);


      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{
        await resetTaskReqData();
        resIsSuccess(_getGetCreateTaskResponse,response);

      }


    } catch (e) {

      resIsFailed(_getGetCreateTaskResponse, e);
      rethrow;



    }

  }

  Future isUpdateLoading({bool? isLoading})async{

    if (isLoading != null){

     this.isLoading = isLoading;

    }
    notifyListeners();
  }

  Future resetData()async{

    list = [];
    notifyListeners();

  }

  Future resetTaskReqData()async{
    createTaskReqModel = CreateTaskReqModel(
        multipleAssignUser: [],
        userList: [],
        userTaskSubPointList: [],
        docList: [],
        multipleTestAssignUser: []
    );
    notifyListeners();


  }

  @override
  Future startTask({StartStopTaskReqModel? startStopTaskReqModel}) async{

    resIsLoading(_startTaskResponse);

    try {

      final response = await taskRepository?.startTask(startStopTaskReqModel: startStopTaskReqModel);

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        final res = BaseResModel(
            statusCode: response?.statusCode,
            message: response?.message,
            data: Data(
              taskId: startStopTaskReqModel?.taskId,
              startStop: true
            )
        );

        print("${res.data?.toJson()} ==== check this data response");

        resIsSuccess(_startTaskResponse,res);
      }

    } catch (e) {
      resIsFailed(_startTaskResponse, e);
      rethrow;

    }
  }

  @override
  Future stopTask({StartStopTaskReqModel? startStopTaskReqModel}) async{
    resIsLoading(_stopTaskResponse);

    try {

      final response = await taskRepository?.stopTask(startStopTaskReqModel: startStopTaskReqModel);

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        resIsSuccess(_stopTaskResponse,response);
      }

    } catch (e) {
      resIsFailed(_stopTaskResponse, e);
      rethrow;
    }
  }

  @override
  Future getRunningTask() async{
    resIsLoading(_getRunningTaskResponse);

    try {

      final response = await taskRepository?.getRunningTask();

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        final runningStartTime = response?.data?[0].startTime;




        resIsSuccess(_getRunningTaskResponse,response);
      }

    } catch (e) {
      resIsFailed(_getRunningTaskResponse, e);
      rethrow;

    }
  }
  
  @override
  Future getTaskDetailsData({required int? id}) async{

    resIsLoading(_getTaskDetailsResponse);


    try {

      final response = await taskRepository?.getTaskDetailsData(id: id);

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        response?.data?.taskUser?.forEach((element) {

          createTaskReqModel.multipleTestAssignUser?.where((e) => e.projectId == element.userId).forEach((mElement) {

           mElement.isAssign = element.isAssign;
           mElement.projectId = element.userId;
           mElement.taskUserID = element.taskUserId;

         });

        });

        resIsSuccess(_getTaskDetailsResponse,response);

      }

    } catch (e) {
      resIsFailed(_getTaskDetailsResponse,e);
      rethrow;

    }


  }

  @override
  Future getCheckAndUnCheckSubPointData({required int? taskSubPointID, required bool? isDone}) async{

    resIsLoading(_getSubPointCheckUnCheckResponse);


    try {


      final response = await taskRepository?.getCheckAndUnCheckSubPointData(taskSubPointID: taskSubPointID, isDone: isDone);


      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        createTaskReqModel.userTaskSubPointList?.where((element) => element.taskSubPointId == response?.data?.taskSubPointId).forEach((element) {

          if(response?.data?.isDone == false){

            element.isDone = 1;

          }else{

            element.isDone = 0;

          }


        });

        resIsSuccess(_getSubPointCheckUnCheckResponse,response);

      }

    } catch (e) {

      resIsFailed(_getSubPointCheckUnCheckResponse, e);
      rethrow;

    }


  }

  @override
  Future updateTaskStatusAndPriorityData() async{

    resIsLoading(_getUpdateStatusAndPriorityResponse);


    try {

      final response = await taskRepository?.updateTaskStatusAndPriorityData(updateTaskStatusAndPriorityRequestModel: UpdateTaskStatusAndPriorityRequestModel(
        taskId: createTaskReqModel.taskID,
        projectId: createTaskReqModel.projectID,
        fieldValue: updateTaskStatusPriorityUiState.fieldValue,
        fieldName: updateTaskStatusPriorityUiState.fieldName
      ));


      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        resIsSuccess(_getUpdateStatusAndPriorityResponse,response);

      }
    } catch (e) {

      resIsFailed(_getUpdateStatusAndPriorityResponse, e);
      rethrow;

    }





  }

  @override
  Future deleteUserInTask({required String? name, required int? id}) async{


    resIsLoading(_deleteUserInTaskResponse);


    try {

      final response = await taskRepository?.deleteUserInTask(name: name,id: id);

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{
        await getTaskDetailsData(id: createTaskReqModel.taskID);
        resIsSuccess(_deleteUserInTaskResponse,response);

      }

    } catch (e) {
      resIsFailed(_deleteUserInTaskResponse,e);
      rethrow;

    }

  }

  @override
  Future saveUserInDetails({required SaveDataInDetailReqMode saveDataInDetailReqMode}) async{

    resIsLoading(_saveUserDetailsResponse);

    try {

      final response = await taskRepository?.saveUserInDetails(saveDataInDetailReqMode: saveDataInDetailReqMode);

      if(response?.statusCode != 1){

        throw response?.message ?? "";


      }else{

        await getTaskDetailsData(id: createTaskReqModel.taskID);

        resIsSuccess(_saveUserDetailsResponse,response);


      }

    } catch (e) {

      resIsFailed(_saveUserDetailsResponse, e);
      rethrow;

    }

  }

}