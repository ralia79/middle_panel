import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _lockScreen extends GetxController {
  double leftMargin = 0;
  var margins = [0.0, 200.0, 100.0, 230.0];
  bool showKeyPad = false, showPass = true;
  int secondRemaining = 60, LockNumber = 60;
  Timer? countdownTimer, LockTimer;
  IconData iconData = Icons.visibility_off;
  TextEditingController _controller = new TextEditingController(text: null);
  Color textColor = Colors.black;
  bool isLock = false, showLock = false;
  String year = "", month = "", day = "";
  int CounterErr = 0;
  List<int> numbers = new List<int>.generate(10, (int index) => index);
  void createRandome() {
    numbers.shuffle();

    update();
  }

  void clickMehods(num) {
    if (num != 20) {
      _controller.text += num.toString();
    } else {
      if (_controller.text.length != 0) {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
      }
    }
    if (_controller.text.length == 6) {
      if (_controller.text == "123456") {
        CounterErr = 0;
        // Navigator.pop(context);
      } else {
        textColor = Colors.red;
        Future.delayed(Duration(milliseconds: 500), () {
          textColor = Colors.black;
          _controller.text = "";
          createRandome();
        });

        secondRemaining = 60;
        countdownTimer?.cancel();
        CounterErr++;

        countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
          secondRemaining--;
        });

        if (CounterErr == 3) {
          showLock = true;
          LockNumber = 60;
          LockTimer?.cancel();
          LockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            LockNumber--;
            Future.delayed(Duration(seconds: 60), () {
              showLock = false;
            });
          });
        } else if (CounterErr == 5) {
          showLock = true;
          LockNumber = 600;
          LockTimer?.cancel();
          LockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            LockNumber--;
            Future.delayed(Duration(seconds: 600), () {
              showLock = false;
            });
          });
        } else if (CounterErr >= 7) {
          showLock = true;
          LockNumber = 60000;
          LockTimer?.cancel();
          LockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            LockNumber--;
          });
          Future.delayed(Duration(seconds: 60000), () {
            showLock = false;
          });
        }
      }
    }

    update();
  }
}
