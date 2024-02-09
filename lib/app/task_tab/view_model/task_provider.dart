import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';
import 'package:osm_flutter/base/base.dart';
import '../domain/request/search_model.dart';
import 'package:osm_flutter/utils/utils.dart';
import '../../auth/domain/dummy/create_task_response.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/request/get_user_and_project_request_model.dart';
import '../domain/respones/get_recent_task_response_model.dart';
import '../domain/respones/get_user_and_project_response_model.dart';

abstract class ITaskProvider {
  Future getRecentTaskListData({RecentTaskRequestModel? recentTaskRequestModel});
  Future getProjectAndAssignUser({GetProjectAndAssignUserRequestModel? getProjectAndAssignUserRequestModel});

}

class TaskProvider extends BaseNotifier implements ITaskProvider{


  final ITaskRepository? taskRepository;


  TaskProvider({this.taskRepository}){
    _resentTaskResponse = AppResponse.loading("");
    _getProjectAndUserResponse = AppResponse.loading("");
  }



  late AppResponse<RecentTaskResponseModel> _resentTaskResponse;
  AppResponse<RecentTaskResponseModel> get resentTaskResponse => _resentTaskResponse;

  late AppResponse<GetProjectAndAssignUserResponseModel> _getProjectAndUserResponse;
  AppResponse<GetProjectAndAssignUserResponseModel> get getProjectAndUserResponse => _getProjectAndUserResponse;

  int? todayCount,comp,leave;

  List<SearchModel> list = [];

  List<SearchModel> projectUserList = [];

  List<SearchModel> list = [];

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


        try {


          final response = await taskRepository?.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: getProjectAndAssignUserRequestModel);


          if(response?.statusCode != 1){

            throw response?.message ?? "";

          }else{


            if(getProjectAndAssignUserRequestModel?.projectId != null){

              response?.data?.projectUser?.where((wElement) => wElement.projectId == getProjectAndAssignUserRequestModel?.projectId).forEach((element) {

                list.add(SearchModel(name: element.displayName,projectId: element.projectId));

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



  Future resetData()async{

    list = [];
    notifyListeners();

  }

}