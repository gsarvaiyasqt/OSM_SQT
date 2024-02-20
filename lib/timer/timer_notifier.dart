import 'dart:async';
import 'package:flutter/cupertino.dart';


class TimerNotifier extends ChangeNotifier{

  Duration? _duration;
  Duration? get duration => _duration;

  Timer? timer;



  differenceRunningTime({required DateTime? startDate}){

    final currentTime = DateTime.now();

    _duration = currentTime.difference(startDate ?? DateTime.now());

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentTime = DateTime.now();
      _duration = currentTime.difference(startDate ?? DateTime.now());

      notifyListeners();
    });

    notifyListeners();
  }


  void stopTimer(){
    _duration = const Duration(seconds: 0);
    timer?.cancel();
    notifyListeners();
  }

}