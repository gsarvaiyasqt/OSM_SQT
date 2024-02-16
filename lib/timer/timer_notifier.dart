import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app/task_tab/view_model/task_provider.dart';

class TimerNotifier extends ChangeNotifier{

 late Duration _duration;
  Duration get duration => _duration;

 late String _time;
 String get time => _time;

  Timer? timer;


 Duration durationTest = Duration.zero;


  TimerNotifier(){

    _duration = Duration.zero;
    _time = "";
  }


 differenceRunningTime(BuildContext context){

   final runningTaskResponse = context.read<TaskProvider>().getRunningTaskResponse;

   final startDate = runningTaskResponse.data?.data?[0].startTime;

   final currentTime = DateTime.now();

   _duration = currentTime.difference(startDate ?? DateTime.now());

   print("${_duration.inHours.remainder(60).toString().padLeft(2, '0')}:${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60)}");

   notifyListeners();
 }

  void updateTime({Duration? duration}){

    if(duration != null){

    }

  }


  void startTimer (Duration? updatedDuration){

    if(updatedDuration != null){


      var minutes =  updatedDuration.inMinutes ?? 0;
      _time = durationToString(minutes);

      timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        var test = updatedDuration;
        var hours =  test.inHours;
        var seconds =  test.inSeconds;
        var minutes =  test.inMinutes;
        minutes += timer.tick;
        _time = durationToString(minutes);
        _duration = Duration(hours: hours,minutes: minutes,seconds: seconds);
        notifyListeners();
      });

    }






    notifyListeners();


   // print("${_duration.inHours} : ${_duration.inMinutes} : ${_duration.inSeconds}==== check this second");
   print("${timer?.tick}==== check this second");

  }

  void stopTimer(){
    _duration = const Duration(seconds: 0);
    timer?.cancel();
    notifyListeners();
  }





}

String durationToString(int minutes) {
  var d = Duration(minutes:minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
}