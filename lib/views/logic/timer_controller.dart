import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  int _minutes = 0;
  int _seconds = 3;

  bool _isTimerEnd = false;

  bool get isTimerEnd => _isTimerEnd;
  String get minutes => _minutes.toString().padLeft(2, "0");
  String get seconds => _seconds.toString().padLeft(2, "0");

  setTimeEnd(bool value) {
    _isTimerEnd = value;
    update();
  }

  setMinutesAndSecond(int m, int s) {
    _minutes = m;
    _seconds = s;
  }

  startTimer() async {
    setTimeEnd(false);
    setMinutesAndSecond(2, 60);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds--;
      if (_minutes == 0 && _seconds == 0) {
        timer.cancel();
        setTimeEnd(true);
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
