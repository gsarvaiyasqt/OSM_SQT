import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/utils/utils.dart';

import '../../../utils/utils.dart';
import '../../auth/domain/dummy/create_task_response.dart';
import '../domain/request/create_task_req_model.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/request/get_status_count.dart';
import '../domain/request/get_user_and_project_request_model.dart';
import '../domain/request/search_model.dart';
import '../domain/respones/get_count_status_response_model.dart';
import '../domain/respones/get_create_task_response.dart';
import '../domain/respones/get_recent_task_response_model.dart';
import '../domain/respones/get_status_and_priority_res_model.dart';
import '../domain/respones/get_user_and_project_response_model.dart';

abstract class ITaskProvider {

  Future getTaskCount({required GetStatusCountRequestModel? getStatusCountRequestModel});
  Future getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
  Future getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
  Future getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType});
  Future getCreateTaskData();

}

class TaskProvider extends BaseNotifier implements ITaskProvider{


  final ITaskRepository? taskRepository;


  TaskProvider({this.taskRepository}){
    _getStatusCountResponse = AppResponse.loading("");
    _resentTaskResponse = AppResponse.loading("");
    _getProjectAndUserResponse = AppResponse.loading("");
    _getGerStatusAndPriorityResponse = AppResponse.loading("");
    _getGetCreateTaskResponse = AppResponse();
  }

  late AppResponse<GetStatusCountResponseModel> _getStatusCountResponse;
  AppResponse<GetStatusCountResponseModel> get getStatusCountResponse => _getStatusCountResponse;


  late AppResponse<RecentTaskResponseModel> _resentTaskResponse;
  AppResponse<RecentTaskResponseModel> get resentTaskResponse => _resentTaskResponse;

  late AppResponse<GetProjectAndAssignUserResponseModel> _getProjectAndUserResponse;
  AppResponse<GetProjectAndAssignUserResponseModel> get getProjectAndUserResponse => _getProjectAndUserResponse;


  late AppResponse<GerStatusAndPriorityResponseModel> _getGerStatusAndPriorityResponse;
  AppResponse<GerStatusAndPriorityResponseModel> get getGerStatusAndPriorityResponse => _getGerStatusAndPriorityResponse;


  late AppResponse<GetCreateTaskResponseModel> _getGetCreateTaskResponse;
  AppResponse<GetCreateTaskResponseModel> get getGetCreateTaskResponse => _getGetCreateTaskResponse;

  int? todayCount,comp,leave;


  List<CreateTaskListModel> listData = [];

  CreateTaskReqModel createTaskReqModel = CreateTaskReqModel(
    multipleAssignUser: [],
    userList: [],
    userTaskSubPointList: [],
    docList: []
  );


  @override
  Future getTaskCount({required GetStatusCountRequestModel? getStatusCountRequestModel}) async{

    resIsLoading(_getStatusCountResponse);

    try {

     final response = await taskRepository?.getCountStatusCount(getStatusCountRequestModel: getStatusCountRequestModel);

     if(response?.statusCode != 1){

       throw response?.message ?? "";

     }else{

       final leave = response?.data?.indexWhere((element) => element.status == "Leave Count");
       final today = response?.data?.indexWhere((element) => element.status == "TodayTask");
       final comp = response?.data?.indexWhere((element) => element.status == "Closed");

      if(leave != null){

        this.leave = response?.data?[leave].taskCount;

      }


       if(today != null){

         todayCount = response?.data?[today].taskCount;

       }

       if(comp != null){

         this.comp = response?.data?[comp].taskCount;

       }

       resIsSuccess(_getStatusCountResponse,response);

     }

    } catch (e) {

      resIsFailed(_getStatusCountResponse, e);
      rethrow;

    }


  }

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

            for(int i = 0; i < taskValueList.length; i ++){

              final hourConvert = formattedTime(timeInSecond: taskValueList[i].totalTimeInMinites ?? 0);

              print("$hourConvert ===  check this hourConvert");

              // final total = hourConvert.fold(0, (sum, item) => sum + item.amount);

              // print("$total ===  check this total check this");

            }

            listData.add(CreateTaskListModel(date: isDate,testList: value));

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


        try {


          final response = await taskRepository?.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: getProjectAndAssignUserRequestModel);


          if(response?.statusCode != 1){

            throw response?.message ?? "";

          }else{


            if(getProjectAndAssignUserRequestModel?.projectId != null){

              response?.data?.projectUser?.where((wElement) => wElement.projectId == getProjectAndAssignUserRequestModel?.projectId).forEach((element) {

                list.add(SearchModel(name: element.displayName,projectId: element.userId));

              }

              );

            }

           resIsSuccess(_getProjectAndUserResponse,response);

          }

        } catch (e) {

          resIsFailed(_getProjectAndUserResponse, e);
          rethrow;

        }


  }
  

  Future updateSearchList(List<ProjectList>? projectList)async{

    if(projectList != null){

      for (var element in projectList) {

        list.add(SearchModel(name: element.projectName,projectId: element.projectId));

      }

    }
    notifyListeners();

  }


  Future resetData()async{

    list = [];
    notifyListeners();

  }

  @override
  Future getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType}) async{



    try {

      resIsLoading(_getGerStatusAndPriorityResponse);

      final response = await taskRepository?.getStatusAndPriorityTerm(getStatusAndPriorityType: getStatusAndPriorityType);

      if(response?.statusCode != 1){

        throw response?.message ?? "";

      }else{

        response?.data?.forEach((element) {

          list.add(SearchModel(name: element.defaultValues,projectId: element.termId));

        });

        resIsSuccess(_getGerStatusAndPriorityResponse,response);

      }


    } catch (e) {

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

        createTaskReqModel = CreateTaskReqModel(
            multipleAssignUser: [],
          docList: [],
          userTaskSubPointList: [],
          userList: [],
        );
        resIsSuccess(_getGetCreateTaskResponse,response);

      }


    } catch (e) {

      resIsFailed(_getGetCreateTaskResponse, e);
      rethrow;



    }



  }

}