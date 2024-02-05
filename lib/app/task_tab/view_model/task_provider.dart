import 'package:osm_flutter/app/task_tab/repository/task_repository.dart';
import 'package:osm_flutter/base/base.dart';

import '../domain/request/get_status_count.dart';
import '../domain/respones/get_count_status_response_model.dart';

abstract class ITaskProvider {

  Future getTaskCount({required GetStatusCountRequestModel? getStatusCountRequestModel});

}

class TaskProvider extends BaseNotifier implements ITaskProvider{


  final ITaskRepository? taskRepository;


  TaskProvider({this.taskRepository}){
    _getStatusCountResponse = AppResponse.loading("");
  }

  late AppResponse<GetStatusCountResponseModel> _getStatusCountResponse;
  AppResponse<GetStatusCountResponseModel> get getStatusCountResponse => _getStatusCountResponse;

  int? todayCount,comp,leave;

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

      if(leave != null){

        this.leave = response?.data?[leave].taskCount;

      }


       if(today != null){

         todayCount = response?.data?[today].taskCount;

       }







       // final todayCount = response?.data?.indexWhere((element) => element.status == "TodayTask");
       // final completedCount = response?.data?.indexWhere((element) => element.status == "");
       // final leaveCount = response?.data?.indexWhere((element) => element.status == "Leave Count");
       //
       // if(todayCount != null){
       //   this.todayCount = (response?.data?[todayCount].taskCount ?? 0).toString();
       // }
       //
       // if(completedCount != null){
       //   comp = (response?.data?[completedCount].taskCount ?? 0).toString();
       // }
       //
       // if(leaveCount != null){
       //   leave = (response?.data?[leaveCount].taskCount ?? 0).toString();
       // }
       //
       // print("leave is ${leave}");
       //



       resIsSuccess(_getStatusCountResponse,response);



     }

    } catch (e) {

      resIsFailed(_getStatusCountResponse, e);
      rethrow;

    }


  }




}