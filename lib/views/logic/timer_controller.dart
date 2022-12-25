import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  int _minutes = 2;
  int _seconds = 60;

  int get minutes => _minutes;
  int get seconds => _seconds;

  startTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds--;
      if (_minutes == 0 && _seconds == 0) {
        timer.cancel();
      } else {
        if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        }
      }
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }
}
