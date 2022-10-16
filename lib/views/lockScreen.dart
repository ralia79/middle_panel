import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:shamsi_date/shamsi_date.dart';

class LockScreen extends StatefulWidget {
  final int lock;
  //
  LockScreen({required this.lock});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  double leftMargin = 0;
  bool _visible = true;
  var margins = [0.0, 200.0, 100.0 , 230.0];
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
  }

  void clickMehods(num) {
    if (num != 20) {
      setState(() {
        _controller.text += num.toString();
      });
    } else {
      if (_controller.text.length != 0) {
        setState(() {
          _controller.text =
              _controller.text.substring(0, _controller.text.length - 1);
        });
      }
    }
    if (_controller.text.length == 6) {
      if (_controller.text == "123456") {
        setState(() {
          CounterErr = 0;
        });
        Navigator.pop(context);
      } else {
        setState(() {
          textColor = Colors.red;
          Future.delayed(Duration(milliseconds: 500), () {
            setState(() {
              textColor = Colors.black;
              _controller.text = "";
              createRandome();
            });
          });

          setState(() {
            secondRemaining = 60;
            countdownTimer?.cancel();
            CounterErr++;
          });

          countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            setState(() {
              secondRemaining--;
            });
          });

          if (CounterErr == 3) {
            setState(() {
              showLock = true;
              LockNumber = 60;
              LockTimer?.cancel();
              LockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                setState(() {
                  LockNumber--;
                });
              });
              Future.delayed(Duration(seconds: 60), () {
                setState(() {
                  showLock = false;
                });
              });
            });
          } else if (CounterErr == 5) {
            showLock = true;
            setState(() {
              LockNumber = 600;
              LockTimer?.cancel();
              LockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
                setState(() {
                  LockNumber--;
                });
              });
              Future.delayed(Duration(seconds: 600), () {
                setState(() {
                  showLock = false;
                });
              });
            });
          } else if (CounterErr >= 7) {
            showLock = true;
            LockNumber = 60000;
            LockTimer?.cancel();
            LockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
              setState(() {
                LockNumber--;
              });
            });
            Future.delayed(Duration(seconds: 60000), () {
              setState(() {
                showLock = false;
              });
            });
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String str = date.toString().replaceAll("00:00:00.000", "");
    List<String> arr = str.split("-");

    Gregorian g =
        Gregorian(int.parse(arr[0]), int.parse(arr[1]), int.parse(arr[2]));
    Jalali j = Jalali.fromGregorian(g);

    setState(() {
      year = j.year.toString() + "/";
      month = j.month.toString() + "/";
      day = j.day.toString();
    });

    if (widget.lock == 1) {
      setState(() {
        isLock = true;
      });
    } else {
      setState(() {
        isLock = false;
      });
    }

    var counter = 1;
    Timer.periodic(new Duration(milliseconds: 10000), (timer) {
      setState(() {
        _visible = false;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (counter == 4) {
          counter = 0;
        }
        setState(() {
          leftMargin = margins[counter];
        });
        counter++;
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          _visible = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var keyStyle = BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: Color(0xFF505050));
    var styleText =
        TextStyle(fontFamily: "Byekan", fontSize: 20.0, color: Colors.white);

    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () => {
          if (!showKeyPad)
            {
              createRandome(),
              if (widget.lock == 0)
                {
                  Navigator.pop(context),
                }
              else if (widget.lock == 1)
                {
                  setState(() {
                    showKeyPad = true;
                  }),
                  countdownTimer =
                      Timer.periodic(Duration(seconds: 1), (timer) {
                    setState(() {
                      secondRemaining--;
                    });
                  }),
                  Future.delayed(Duration(seconds: 60), () {
                    countdownTimer?.cancel();
                    setState(() {
                      showKeyPad = false;
                      secondRemaining = 60;
                      _controller.text = "";
                    });
                  })
                }
            }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Container(
                  width: widthScreen,
                  height: heightScreen,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: widthScreen * 0.7,
                          height: heightScreen / 1.5,
                          margin: EdgeInsets.only(left: leftMargin),
                          child: Container(
                            child: Stack(
                              children: [
                                isLock
                                    ? Container(
                                        // alignment: Alignment.bottomRight,
                                        margin:
                                            EdgeInsets.only(top: 100, left: 230),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                          size: 40.0,
                                        ),
                                      )
                                    : SizedBox(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Lottie.asset(
                                              "assets/images/weather_cloudynight.json",
                                              width: 200.0,
                                              height: 200.0),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "22 ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25.0,
                                                  fontFamily: "Byekan"),
                                            ),
                                            Text(
                                              "°C",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontFamily: "Byekan"),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                                          child: Container(
                                            child: DigitalClock(
                                              is24HourTimeFormat: true,
                                              areaDecoration: BoxDecoration(
                                                  color:
                                                      Color.fromARGB(0, 0, 0, 0)),
                                              areaAligment:
                                                  AlignmentDirectional.center,
                                              hourMinuteDigitDecoration:
                                                  BoxDecoration(
                                                      color: Colors.transparent),
                                              hourMinuteDigitTextStyle: TextStyle(
                                                  fontSize: 40.0,
                                                  color: Colors.white,
                                                  fontFamily: "Byekan"),
                                              secondDigitTextStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontFamily: "Byekan"),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 25.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                year,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: "Byekan",
                                                ),
                                              ),
                                              Text(
                                                month,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: "Byekan",
                                                ),
                                              ),
                                              Text(
                                                day,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: "Byekan",
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            showKeyPad
                ? Container(
                    width: widthScreen,
                    height: heightScreen,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(177, 0, 0, 0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 70.0, horizontal: 70.0),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(243, 112, 112, 112),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (widthScreen / 2) - 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 200.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (iconData ==
                                                    Icons.visibility) {
                                                  setState(() {
                                                    iconData =
                                                        Icons.visibility_off;
                                                    showPass = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    iconData = Icons.visibility;
                                                    showPass = false;
                                                  });
                                                }
                                              },
                                              child: Icon(
                                                iconData,
                                                size: 30.0,
                                                color: Colors.white,
                                              )),
                                          Container(
                                            width: 400,
                                            height: 40,
                                            child: TextField(
                                              obscureText: showPass,
                                              controller: _controller,
                                              enabled: false,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontFamily: "Byekan",
                                                  color: textColor),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ثانیه",
                                                style: styleText,
                                              ),
                                              Text(
                                                secondRemaining.toString(),
                                                style: styleText,
                                              ),
                                              Text(
                                                " زمان باقی مانده : ",
                                                style: styleText,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: (widthScreen / 2) - 70,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[0]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[0].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[1]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[1].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[2]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[2].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                showKeyPad = false;
                                                secondRemaining = 60;
                                                countdownTimer?.cancel();
                                                _controller.text = "";
                                              });
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                  "لغو",
                                                  style: styleText,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[3]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[3].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[4]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[4].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[5]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[5].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[6]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[6].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[7]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[7].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[8]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[8].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(numbers[9]);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Text(
                                                    numbers[9].toString(),
                                                    style: styleText),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              clickMehods(20);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              width: 60,
                                              height: 60,
                                              decoration: keyStyle,
                                              child: Center(
                                                child: Icon(
                                                  Icons.backspace_outlined,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            showLock
                ? Container(
                    color: Color.fromARGB(232, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: EdgeInsets.all(100.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                LockNumber.toString(),
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontFamily: "Byekan",
                                    color: Colors.white),
                              ),
                              Text(
                                "پس از اتمام شمارنده دوباره تلاش کنید",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Byekan",
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
