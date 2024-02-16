import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../app/task_tab/view_model/task_provider.dart';

class TimerNotifier extends ChangeNotifier{

  Duration? _duration;
  Duration? get duration => _duration;

  Timer? timer;


 differenceRunningTime(BuildContext context){

   final runningTaskResponse = context.read<TaskProvider>().getRunningTaskResponse;

   final startDate = runningTaskResponse.data?.data?[0].startTime;

   final currentTime = DateTime.now();

   _duration = currentTime.difference(startDate ?? DateTime.now());

   print("${_duration?.inSeconds.remainder(60)} ======= check duration remoider");

   timer = Timer.periodic(Duration(seconds: 1), (test) {
     Duration(seconds: _duration?.inSeconds ?? 0);
     notifyListeners();
   }
   );

   print("${_duration?.inHours.remainder(60).toString().padLeft(2, '0')}:${_duration?.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_duration?.inSeconds.remainder(60)}");

   notifyListeners();
 }

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