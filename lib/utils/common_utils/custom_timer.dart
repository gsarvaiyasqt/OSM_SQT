part of utils;

ValueNotifier<Duration> timerValueNotifier = ValueNotifier(const Duration(seconds: 0));
Timer? timer;
class OtpTimer extends ChangeNotifier{
  bool _isTimer = false;
  bool get isTimer => _isTimer;
  startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final test = const Duration(seconds: 60).inSeconds - timer.tick;
      if(timer.tick <= 60){
        _isTimer = true;
        timerValueNotifier.value = Duration(seconds: test);
      }else{
        _isTimer = false;
        timer.cancel();
      }
      notifyListeners();
    }
    );
  }
  stopTimer(){
    _isTimer = false;
    timer?.cancel();
    timerValueNotifier.value= const Duration(seconds: 0);
    notifyListeners();
  }
}

