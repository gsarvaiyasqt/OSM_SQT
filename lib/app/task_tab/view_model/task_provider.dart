import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:osm_flutter/base/base.dart';
import '../domain/request/create_task_req_model.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/request/search_model.dart';
import 'package:osm_flutter/utils/utils.dart';
import '../domain/respones/get_create_task_response.dart';
import '../../auth/domain/dummy/create_task_response.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/respones/get_recent_task_response_model.dart';
import '../domain/request/get_user_and_project_request_model.dart';
import '../domain/respones/get_status_and_priority_res_model.dart';
import '../domain/respones/get_user_and_project_response_model.dart';
import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';

abstract class ITaskProvider {
  Future getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
  Future getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});
  Future getStatusAndPriorityTerm({GetStatusAndPriorityType? getStatusAndPriorityType});
  Future getCreateTaskData();

}

class TaskProvider extends BaseNotifier implements ITaskProvider{


  final ITaskRepository? taskRepository;


  TaskProvider({this.taskRepository}){
    _resentTaskResponse = AppResponse.loading("");
    _getProjectAndUserResponse = AppResponse.loading("");
    _getGerStatusAndPriorityResponse = AppResponse.loading("");
    _getGetCreateTaskResponse = AppResponse();
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



    print("getProjectAndAssignUserRequestModel is ${getProjectAndAssignUserRequestModel?.projectId}");

        resIsLoading(_getProjectAndUserResponse);


       await isUpdateLoading(isLoading: true);


        try {


          final response = await taskRepository?.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: getProjectAndAssignUserRequestModel);


          if(response?.statusCode != 1){

            throw response?.message ?? "";

          }else{

            if(getProjectAndAssignUserRequestModel?.projectId != null){

              response?.data?.projectUser?.where((wElement) => wElement.projectId == getProjectAndAssignUserRequestModel?.projectId).forEach((element) {

                list.add(SearchModel(name: element.displayName,projectId: element.projectId));

              });


              final listData =  getProjectAndAssignUserRequestModel?.multipleUserList ??= [];

              if(listData != null){

                for (var element in listData) {

                  final isSelected = list.map((e) => e.projectId ?? "").contains(element.projectId) == true;

                }





              }


              getProjectAndAssignUserRequestModel?.multipleUserList?.forEach((element) {

                print("getProjectAndAssignUserRequestModel data id is ${element.projectId} and name is ${element.name}");

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

  Future<bool?> isUpdateLoading({bool? isLoading})async{

    if (isLoading != null){

     this.isLoading = isLoading;

    }

    notifyListeners();

    return false;
  }

  Future resetData()async{

    list = [];
    notifyListeners();

  }

}