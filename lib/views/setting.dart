import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:vikav/main.dart';
import 'package:vikav/views/landingPage.dart';
import 'package:vikav/views/lockScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final netInfo = NetworkInfo();
  var MyIp = "Empty";
  TextStyle text1 = TextStyle(fontSize: 30.0 , color: Colors.white);

  @override
  void initState() {
    getMyIp();
    super.initState();
  }

  Future<void> getMyIp() async {
    var Ip = await netInfo.getWifiIP();
    setState(() {
      MyIp = Ip.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    int Counter = 0;
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
            child: Container(
              width: widthScreen,
              height: heightScreen,
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
                    margin: EdgeInsets.only(left: widthScreen * 0.12),
                    width: widthScreen * 0.85,
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1 , color: Colors.white54),
                            borderRadius: BorderRadius.circular(5.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ip" , style: text1,) ,
                                Text(MyIp , style: text1,)
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
        ),
      ),
    );
  }
}
