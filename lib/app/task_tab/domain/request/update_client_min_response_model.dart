class UpdateClientMinsResponseModel{

  int? userTaskTimerID;
  int? oldTotalTimeInMinutes;
  int? totalMins;
  int? taskId;
  DateTime? taskDate;
  String? taskUserName;
  int? projectId;

  UpdateClientMinsResponseModel({this.projectId,this.taskId,this.taskUserName,this.userTaskTimerID,this.oldTotalTimeInMinutes,this.taskDate,this.totalMins});


  Map<String,dynamic>toMap(){

    return {
      "UserTaskTimerID":userTaskTimerID,
      "OldTotalTimeInMinutes":oldTotalTimeInMinutes,
      "TotalTimeInMinutes": totalMins,
      "TaskID":taskId,
      "TaskDate":taskDate,
      "TaskUserName":taskUserName,


    };

  }

}