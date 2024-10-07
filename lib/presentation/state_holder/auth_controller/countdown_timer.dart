import 'package:get/get.dart';

class CountdownTimer extends GetxController {
  int _timeLeft = 20;

  int get timeLeft => _timeLeft;

  void resetTime() {
    if (_timeLeft != 20) {
      _timeLeft = 20;
    }
  }

  void decreaseTime() {
    _timeLeft--;
    update();
  }
}
