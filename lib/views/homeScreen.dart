import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:vikav/views/landingPage.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vikav/views/lockScreen.dart';
import 'package:vikav/views/openDoor.dart';
import 'package:vikav/views/temp.dart';
import 'package:vikav/views/walkiTalki.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int Counter = 0;
  late Timer timer;
  final netInfo = NetworkInfo();
  var MyIp = "Empty";

  List<List> items = [
    ["برق اصلی", false, Icons.bolt_outlined],
    ["چراغ خواب", false, Icons.light_outlined],
    ["کامپیوتر", false, Icons.computer],
    ["رینگ لایت", false, Icons.lightbulb_outline_sharp],
  ];

  List<List> scenarioList = [
    ["خواب", false, Icons.bed_outlined],
    ["بیداری", false, Icons.light_mode_outlined],
  ];
  var radiator = "assets/images/radiator_active.png";
  var cooler = "assets/images/cooler_deactive.png";
  bool isOff = false;

  Future<void> getMyIp() async {
    var Ip = await netInfo.getWifiIP();
    setState(() {
      MyIp = Ip.toString();
    });
  }

  void TimerHandler() {
    timer = Timer(Duration(seconds: 1), () {
      setState(
        () {
          Counter++;
        },
      );
    });

    Timer(Duration(seconds: 1), () {
      if (Counter == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LockScreen(
              lock: 0,
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    getMyIp();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889)
        .then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = true;
      udpSocket.listen((e) {
        Datagram? dg = udpSocket.receive();
        if (dg != null) {
          List listData = utf8.decode(dg.data).split("-");
          if (listData[0] != "remove") {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WalkyTlkyScreen(
                      true, listData[0], listData[1], listData[2]),
                ),
              );
            });
          } else {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          }
        }
      });
    });

    TimerHandler();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            Counter = 0;
          });
        },
        child: Container(
          width: widthScreen,
          height: heightScreen,
          color: Colors.black,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LandigScreen()),
                      );
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF303030),
                      ),
                      child: Icon(
                        Icons.list_rounded,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OpenDoorScreen()),
                      );
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF303030),
                      ),
                      child: Icon(
                        Icons.doorbell_outlined,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TempScreen()));
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: 170.0,
                      height: 300.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF303030),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 150.0,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: SleekCircularSlider(
                                      innerWidget: (percentage) => Center(
                                          child: Text(
                                        isOff
                                            ? "خاموش"
                                            : percentage.toInt().toString() +
                                                "°C",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "Byekan",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                      appearance: CircularSliderAppearance(
                                          size: 120.0,
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
                                      width: 160.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            child: Container(
                                              width: 30,
                                              height: 30,
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
                                              width: 30,
                                              height: 30,
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
                            Column(
                              children: [
                                Container(
                                  width: 150.0,
                                  height: 1.0,
                                  color: Color(0xFF707070),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "٪  رطوبت  ",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "Byekan",
                                              color: Color(0xFFA5A5A5)),
                                        ),
                                        Text(
                                          "14",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: "Byekan",
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        width: 1,
                                        height: 50,
                                        color: Color(0xFF6B6B6B),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "°C  دما  ",
                                          style: TextStyle(
                                              fontFamily: "Byekan",
                                              fontSize: 16.0,
                                              color: Color(0xFFA5A5A5)),
                                        ),
                                        Text(
                                          "26",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: "Byekan",
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: 170.0,
                      height: 220.0,
                      color: Color.fromARGB(0, 255, 255, 255),
                    )
                  ],
                ),
              ),
            
            
            
              Container(
                alignment: Alignment.center,
                width: 250.0,
                child: Wrap(
                  spacing: 18.0,
                  runSpacing: 18.0,
                  children: List.generate(items.length, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          items[index][1] = !items[index][1];
                        });
                      },
                      child: Container(
                        width: 110.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              items[index][2],
                              color: items[index][1]
                                  ? Color(0xFFF6BD00)
                                  : Colors.white,
                              size: 45.0,
                            ),
                            Text(
                              items[index][0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                
                                color: items[index][1]
                                    ? Color(0xFFF6BD00)
                                    : Colors.white,

                                    fontSize: 20.0 ,
                                    
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5.0),
                width: 125.0,
                child: Wrap(
                  spacing: 18.0,
                  runSpacing: 18.0,
                  children: List.generate(scenarioList.length, (index) {
                    return InkWell(
                      onTap: (() => {
                            setState(() {
                              for (var i = 0; i < scenarioList.length; i++) {
                                scenarioList[i][1] = false;
                              }

                              scenarioList[index][1] = true;
                              Future.delayed(Duration(seconds: 1), () {
                                setState(() {
                                  scenarioList[index][1] = false;
                                });
                              });
                            })
                          }),
                      child: Container(
                        width: 110.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              scenarioList[index][2],
                              color: scenarioList[index][1]
                                  ? Color(0xff8775FF)
                                  : Colors.white,
                              size: 45.0,
                            ),
                            Text(
                              scenarioList[index][0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: scenarioList[index][1]
                                    ? Color(0xff8775FF)
                                    : Colors.white,
                                    fontSize: 20.0
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 125.0,
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    InkWell(
                      onTap: onJoin,
                      child: Container(
                        width: 110.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.mic_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 45.0,
                            ),
                            Text(
                              "بیسیم",
                              
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "Byekan"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LockScreen(lock: 1)),
                            )
                          }),
                      child: Container(
                        width: 110.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: Color(0xFFFFFFFF),
                              size: 45.0,
                            ),
                            Text(
                              "قفل صفحه",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Byekan",
                              ),
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
    );
  }

  void onJoin() {
    // List<List> temp =[];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalkyTlkyScreen(false, "", "none", ""),
      ),
    );
  }
}
