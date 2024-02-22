class UpdateTimerRequestModel{
  int? userTaskTimerID;
  String? timerDate;
  // DateTime? timerDate;
  DateTime? startTime;
  DateTime? endTime;
  // DateTime? oldTimerDate;
  String? oldTimerDate;
  DateTime? oldStartTime;
  DateTime? oldEndTime;
  int? taskId;
  String? taskUserName;
  int? projectId;

  UpdateTimerRequestModel({this.endTime,this.startTime,this.projectId,this.taskId,this.oldEndTime,this.oldStartTime,
  this.oldTimerDate,this.taskUserName,this.timerDate,this.userTaskTimerID});


  Map<String,dynamic>toMap(){
    return {
      "UserTaskTimerID":userTaskTimerID,
      "TimerDate":timerDate,
      "StartTime":startTime?.toIso8601String(),
      "EndTime":endTime?.toIso8601String(),
      "OldTimerDate":oldTimerDate,
      "OldStartTime":oldStartTime?.toIso8601String(),
      "OldEndTime":oldEndTime?.toIso8601String(),
      "TaskID":taskId,
      "TaskUserName":taskUserName,
      "ProjectID":projectId,

    };
  }

}