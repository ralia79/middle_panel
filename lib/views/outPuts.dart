import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vikav/main.dart';
import 'package:vikav/views/landingPage.dart';
import 'package:vikav/views/lockScreen.dart';

class OutPutsScreen extends StatefulWidget {
  const OutPutsScreen({Key? key}) : super(key: key);

  @override
  State<OutPutsScreen> createState() => _OutPutsScreenState();
}

class _OutPutsScreenState extends State<OutPutsScreen> {
  List<List> nameOfItems = [
    ["اتاق خواب", false, Icons.bed_outlined],
    ["حمام", false, Icons.bathroom],
    ["دستشویی", false, Icons.wc_outlined],
    ["رختکن", false, Icons.bathroom],
    ["سونا", false, Icons.bathroom],
    ["جکوزی", false, Icons.bathroom],
    ["اتاق خواب", false, Icons.bathroom],
    ["حمام", false, Icons.bathroom],
    ["دستشویی", false, Icons.bathroom],
    ["رختکن", false, Icons.bathroom],
    ["سونا", false, Icons.bathroom],
    ["جکوزی", false, Icons.bathroom],
    ["اتاق خواب", false, Icons.bathroom],
    ["حمام", false, Icons.bathroom],
    ["دستشویی", false, Icons.bathroom],
    ["رختکن", false, Icons.bathroom],
    ["سونا", false, Icons.bathroom],
    ["جکوزی", false, Icons.bathroom],
    ["اتاق خواب", false, Icons.bathroom],
    ["حمام", false, Icons.bathroom],
    ["دستشویی", false, Icons.bathroom],
    ["رختکن", false, Icons.bathroom],
    ["سونا", false, Icons.bathroom],
    ["جکوزی", false, Icons.bathroom],
  ];
  List<List> Categorys = [
    ["همه", true],
    ["خواب", false],
    ["میهمانی", false],
    ["مسافرت", false],
    ["رقص", false],
    ["تولد", false]
  ];
  int Counter = 0;
  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
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
                  width: widthScreen * 0.65,
                  child: ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: List.generate(
                          nameOfItems.length,
                          (index) {
                            return InkWell(
                              onTap: (() => {
                                    setState(() {
                                      nameOfItems[index][1] =
                                          !nameOfItems[index][1];
                                    })
                                  }),
                              child: Container(
                                width: 110.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFF303030)),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        nameOfItems[index][2],
                                        size: 40.0,
                                        color: nameOfItems[index][1]
                                            ? Color(0xFFF6BD00)
                                            : Colors.white,
                                      ),
                                      Text(
                                        nameOfItems[index][0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "Byekan",
                                          color: nameOfItems[index][1]
                                              ? Color(0xFFF6BD00)
                                              : Colors.white,
                                        ),
                                      )
                                    ]),
                              ),
                            );
                          },
                        ),
                      )
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
                                Categorys[index][1]
                                    ? Container(
                                        margin: EdgeInsets.only(left: 5),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(0xFFF6BD00)),
                                      )
                                    : SizedBox(
                                        width: 0,
                                        height: 0,
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
