import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vikav/views/landingPage.dart';
import 'package:vikav/views/lockScreen.dart';

class OpenDoorScreen extends StatefulWidget {
  const OpenDoorScreen({Key? key}) : super(key: key);

  @override
  State<OpenDoorScreen> createState() => _OpenDoorScreenState();
}

class _OpenDoorScreenState extends State<OpenDoorScreen> {
  List<IconData> iconsActive = [];
  bool DoNotDistrub = false;
  int Counter = 0;

  void checkActive(num) {
    if (num == 1) {
      setState(() {
        if (iconsActive.contains(Icons.phone)) {
          iconsActive.remove(Icons.phone);
        } else {
          iconsActive.add(Icons.phone);
        }
      });
    } else if (num == 2) {
      setState(() {
        if (iconsActive.contains(Icons.mic_off)) {
          iconsActive.remove(Icons.mic_off);
        } else {
          iconsActive.add(Icons.mic_off);
        }
      });
    } else if (num == 3) {
      setState(() {
        if (iconsActive.contains(Icons.volume_up)) {
          iconsActive.remove(Icons.volume_up);
        } else {
          iconsActive.add(Icons.volume_up);
        }
      });
    } else if (num == 4) {
      setState(() {
        if (iconsActive.contains(Icons.vpn_key)) {
          Fluttertoast.showToast(msg: "درب در حال باز شدن میباشد");
        } else {
          iconsActive.add(Icons.vpn_key);
          Timer(
              Duration(milliseconds: 1000),
              () => setState(() {
                    iconsActive.remove(Icons.vpn_key);
                  }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Timer(
    //   Duration(seconds: 1),
    //   (() => setState(
    //         () {
    //           Counter++;
    //         },
    //       )),
    // );
    // Timer(Duration(seconds: 1), () {
    //   if (Counter == 60) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => LockScreen(
    //           lock: 0,
    //         ),
    //       ),
    //     );
    //   }
    // });

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            Counter = 0;
          });
        },
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Image.asset("assets/images/openDoor.jpg")),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              checkActive(1);
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF707070),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 40.0,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "پاسخ دادن",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          color: Colors.white,
                                          fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              checkActive(2);
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF707070),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.mic_off,
                                      size: 40.0,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "بیصدا کردن",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          color: Colors.white,
                                          fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              checkActive(3);
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF707070),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.volume_up,
                                      size: 40.0,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      "بلندگو",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          color: Colors.white,
                                          fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              checkActive(4);
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF707070),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.vpn_key,
                                      size: 40.0,
                                      color: Colors.yellowAccent,
                                    ),
                                    Text(
                                      "بازکردن درب",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          color: Colors.white,
                                          fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                DoNotDistrub = true;
                              });
                            },
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF707070),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.do_disturb,
                                      size: 40.0,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "مزاحم نشوید",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          color: Colors.white,
                                          fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LandigScreen()),
                              );
                            }),
                            child: Container(
                              width: 110,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xFF707070),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      size: 40.0,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      "بازگشت",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          color: Colors.white,
                                          fontSize: 17.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            DoNotDistrub
                ? Container(
                    color: Color.fromARGB(183, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                        child: Container(
                      width: 400,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF707070),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "در حالت مزاحم نشوید قرار دارید",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: "Byekan"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      DoNotDistrub = false;
                                    });
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFF303030),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "ادامه",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          fontSize: 15.0,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Container(
                                width: 110,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xFF303030),
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LandigScreen(),
                                        ),
                                      );
                                    },
                                    child: Center(
                                        child: Text(
                                      "بازگشت",
                                      style: TextStyle(
                                          fontFamily: "Byekan",
                                          fontSize: 15.0,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                    )),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
