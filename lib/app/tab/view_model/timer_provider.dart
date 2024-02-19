

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:provider/provider.dart';

class TimeProvider extends ChangeNotifier{

  Timer? timer;
  bool startStop = true;
  String elapsedTime = '';

  Duration? diffRealTimeDuration;


  Stopwatch watch = Stopwatch();

  differenceRunningTime(BuildContext context){

    final runningTaskResponse = context.read<TaskProvider>().getRunningTaskResponse;

    final startDate = runningTaskResponse.data?.data?[0].startTime;

    final currentTime = DateTime.now();

    diffRealTimeDuration = currentTime.difference(startDate ?? DateTime.now());

    print("${diffRealTimeDuration?.inHours.remainder(60).toString().padLeft(2, '0')}:${diffRealTimeDuration?.inMinutes.remainder(60).toString().padLeft(2, '0')}:${diffRealTimeDuration?.inSeconds.remainder(60)}");

    // print("$differenceTime == check diffrence");

    notifyListeners();
  }

  updateTime(Timer timer) {
    if (watch.isRunning) {
      elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      notifyListeners();
    }
  }

  startOrStop() {
    if(startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    startStop = false;
    watch.start();
    timer = Timer.periodic(Duration(milliseconds: 100), updateTime);

    notifyListeners();
  }

  stopWatch() {

    startStop = true;
    watch.stop();
    setTime();

    notifyListeners();
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;

    elapsedTime = transformMilliSeconds(timeSoFar);

    notifyListeners();
  }


  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr";
  }
}