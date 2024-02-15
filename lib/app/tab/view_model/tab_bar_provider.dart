import 'dart:async';

import 'package:flutter/cupertino.dart';

class TabBarProvider extends ChangeNotifier{

  int currentIndex = 0;

  tabChangeIndex({required int index}){
    currentIndex = index;
    notifyListeners();
  }
}