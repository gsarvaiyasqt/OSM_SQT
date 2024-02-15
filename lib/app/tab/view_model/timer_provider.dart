

import 'dart:async';

import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier{

  Timer? timer;
  bool startStop = true;
  String elapsedTime = '';

  Stopwatch watch = Stopwatch();


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