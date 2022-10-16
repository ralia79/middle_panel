import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vikav/views/Scenarios.dart';
import 'package:vikav/views/lockScreen.dart';
import 'package:vikav/views/openDoor.dart';
import 'package:vikav/views/outPuts.dart';
import 'package:vikav/views/setting.dart';
import 'package:vikav/views/temp.dart';
import 'package:vikav/views/walkiTalki.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int Counter = 0;
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 1),
      (() => setState(
            () {
              Counter++;
            },
          )),
    );
    Timer(Duration(seconds: 1), () {
      if (Counter == 60) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LockScreen(
                    lock: 0,
                  )),
        );
      }
    });
    return GestureDetector(
      onTap: () {
        setState(() {
          Counter = 0;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OutPutsScreen()),
                    );
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "میانبر ها",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScenariosScreen()),
                    );
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.rocket_launch,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "سناریو ها",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onJoin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.mic_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "بیسیم",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenDoorScreen()),
                    );
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.doorbell_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "بازکردن درب",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingScreen()))
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.settings_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "تنظیمات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
                InkWell(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TempScreen()));
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.thermostat_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "دما",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LockScreen(
                                lock: 1,
                              )),
                    );
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Container(
                        width: 180.0,
                        height: MediaQuery.of(context).size.height * .3,
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: Color(0xFFFFFFFF),
                              size: 50.0,
                            ),
                            Text(
                              "قفل صفحه",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "Byekan"),
                            ),
                          ],
                        ))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onJoin() {
    // List<List> temp = [];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WalkyTlkyScreen(false, "", "none", ""),
      ),
    );
  }
}
