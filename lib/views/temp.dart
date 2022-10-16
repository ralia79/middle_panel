import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vikav/main.dart';
import 'package:vikav/views/landingPage.dart';
import 'package:vikav/views/lockScreen.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  List<List> Categorys = [
    ["اتاق 1", true],
    ["اتاق 2", false],
    ["اتاق 3", false],
    ["اتاق 4", false],
    ["اتاق 5", false],
    ["اتاق 6", false]
  ];
  int Counter = 0;
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var radiator = "assets/images/radiator_active.png";
    var cooler = "assets/images/cooler_deactive.png";
    bool isOff = false;
    Timer(
      Duration(seconds: 1),
      (() => setState(
            () {
              Counter++;
            },
          )),
    );
    Timer(Duration(seconds: 1), () {
      if (Counter == 400) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LockScreen(
                    lock: 0,
                  )),
        );
      }
    });
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            Counter = 0;
          });
        },
        child: Container(
          color: Colors.black,
          width: widthScreen,
          height: heightScreen,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 70.0, horizontal: 0.0),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: widthScreen * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF303030),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.home_outlined,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandigScreen()));
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF303030),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: widthScreen * 0.15),
                  width: 200.0,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 190.0,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SleekCircularSlider(
                                  innerWidget: (percentage) => Center(
                                      child: Text(
                                    isOff
                                        ? "خاموش"
                                        : percentage.toInt().toString() + "°C",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: "Byekan",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  appearance: CircularSliderAppearance(
                                      size: 180.0,
                                      customWidths: CustomSliderWidths(
                                        progressBarWidth: 5,
                                        handlerSize: 9,
                                        trackWidth: 5,
                                        shadowWidth: 2,
                                      ),
                                      customColors: CustomSliderColors(
                                        progressBarColor: Color(0xFFFF8C00),
                                        shadowColor: Color(0xFF0000),
                                        dotColor: Color(0xFFFF8C00),
                                        trackColor: Color(0xFF5A5A5A),
                                      )),
                                  min: 20,
                                  max: 40,
                                  initialValue: 20,
                                  onChange: (value) => {
                                    if (value == 20)
                                      isOff = true
                                    else
                                      isOff = false
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 140.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 40.0,
                                          height: 40.0,
                                          child: Image.asset(radiator),
                                        ),
                                        onTap: () => {
                                          setState(() {
                                            radiator =
                                                "assets/images/radiator_active.png";
                                            cooler =
                                                "assets/images/cooler_deactive.png";
                                          })
                                        },
                                      ),
                                      InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 4, left: 10.0),
                                          width: 40.0,
                                          height: 40.0,
                                          child: Image.asset(cooler),
                                        ),
                                        onTap: () => {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "این قابلیت در این نسخه در دسترس نمیباشد")
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 300.0,
                  margin: EdgeInsets.only(left: (widthScreen * 0.1) + 250),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                color: Color(0xFF303030),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "دما",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Byekan",
                                      fontSize: 18.0),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "22",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Byekan",
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "°C",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Byekan",
                                          fontSize: 20.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                color: Color(0xFF303030),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "رطوبت",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Byekan",
                                      fontSize: 18.0),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "22",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Byekan",
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "%",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Byekan",
                                          fontSize: 20.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 240.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                            child: Text(
                          "انجام بده",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Byekan",
                              fontSize: 20.0),
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: widthScreen * 0.8),
                  width: widthScreen * 2.0,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      border: Border(
                          left: BorderSide(
                              width: 0.5, color: Color(0xFF303030)))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: List.generate(Categorys.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                for (var i = 0; i < Categorys.length; i++) {
                                  Categorys[i][1] = false;
                                }
                                Categorys[index][1] = !Categorys[index][1];
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  Categorys[index][0],
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Byekan",
                                      fontSize: 22.0,
                                      color: Categorys[index][1]
                                          ? Color(0xFFF6BD00)
                                          : Colors.white),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Categorys[index][1]
                                          ? Color(0xFFF6BD00)
                                          : Colors.transparent),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
