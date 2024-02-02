import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerNotifier extends ChangeNotifier{

 late Duration _duration;
  Duration get duration => _duration;

  Timer? timer;

  void startTimer (){

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      _duration = Duration(seconds: timer.tick);

    });

    notifyListeners();

  }

  void stopTimer(){
    _duration = const Duration(seconds: 0);
    timer?.cancel();
    notifyListeners();
  }





}