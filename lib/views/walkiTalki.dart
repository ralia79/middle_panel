import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

// ignore: import_of_legacy_library_into_null_safe
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// ignore: unused_import
import 'package:fluttertoast/fluttertoast.dart';
import 'package:network_info_plus/network_info_plus.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:random_words/random_words.dart';
import 'package:flutter/material.dart';
import 'package:vikav/utils/appID.dart';
import 'package:vikav/views/homeScreen.dart';

class WalkyTlkyScreen extends StatefulWidget {
  final bool isAuther;
  final String chanelName;
  final String senderIp;

  final String activePanel;

  const WalkyTlkyScreen(
      this.isAuther, this.chanelName, this.senderIp, this.activePanel);

  @override
  State<WalkyTlkyScreen> createState() => _WalkyTlkyScreenState();
}

class _WalkyTlkyScreenState extends State<WalkyTlkyScreen> {
  bool pressed = false;
  List<List> panels = [
    ["panel 1", false, "192.168.1.61", false],
    ["panel 2", false, "192.168.1.60", false],
  ];
  List CurrentDevice = [];
  static final _users = <int>[];
  final _infoStrings = <String>[];
  String? chanelName;
  bool isStart = false;
  bool isRemoved = false;
  bool isConected = false;
  String DeviceName = "panel 1";
  final netInfo = NetworkInfo();
  var MyIp = "Empty";

  @override
  void dispose() {
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getMyIp();

    // ! if By udp req go in this page
    if (widget.isAuther) {
      setState(() {
        changePanels();
        chanelName = widget.chanelName;
        isConected = true;
      });
      initialize();
      var sender = InternetAddress(widget.senderIp);
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888)
          .then((RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;
        Future.delayed(Duration(seconds: 1), () {
          udpSocket.send(utf8.encode("yes-${MyIp}"), sender, 8888);
        });
      });
      // * if he/she is creator this tunel
    } else {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888)
          .then((RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;
        udpSocket.listen((e) {
          Datagram? dg = udpSocket.receive();
          if (dg != null) {
            List listData = utf8.decode(dg.data).split("-");
            if (listData[0] == "yes") {
              // ! If the IP of the panel is equal to one of the panels in my list, it will be displayed in the panel
              for (int i = 0; i < panels.length; i++) {
                if (panels[i][2] == listData[1]) {
                  setState(() {
                    panels[i][3] = true;
                  });
                }
              }
            }
          }
        });
      });
    }
  }

  Future<void> getMyIp() async {
    var Ip = await netInfo.getWifiIP();
    setState(() {
      MyIp = Ip.toString();
    });
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.enableLocalVideo(false);
    await AgoraRtcEngine.enableLocalAudio(true);
    await AgoraRtcEngine.muteLocalAudioStream(true);
    await AgoraRtcEngine.joinChannel(null, chanelName, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    /// Use this function to obtain the uid of the person who joined the channel
    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: widthScreen,
        height: heightScreen,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 0.0),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      isRemoved ? null : sendRmoveData();
                      _users.clear();
                      AgoraRtcEngine.leaveChannel();
                      AgoraRtcEngine.destroy();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
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
                        Icons.home_outlined,
                        size: 45.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: widthScreen - 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (widthScreen - 80) / 4,
                            margin: EdgeInsets.only(left: 30.0),
                            child: Center(
                              child: GestureDetector(
                                onTapUp: (TapUpDetails details) {
                                  setState(() {
                                    pressed = false;
                                  });
                                  isStart
                                      ? AgoraRtcEngine.muteLocalAudioStream(
                                          true)
                                      : null;
                                },
                                onTapDown: (TapDownDetails details) {
                                  setState(() {
                                    pressed = true;
                                  });

                                  AgoraRtcEngine.muteLocalAudioStream(false);
                                },
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: pressed
                                            ? Colors.white
                                            : Color(0xFF707070),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Icon(
                                    pressed ? Icons.mic : Icons.mic_off_rounded,
                                    size: 50.0,
                                    color: pressed
                                        ? Colors.white
                                        : Color(0xFF707070),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isConected = !isConected;
                              });
                              isConected
                                  ? widget.isAuther
                                      ? {
                                          isRemoved ? null : sendRmoveData(),
                                          _users.clear(),
                                          AgoraRtcEngine.leaveChannel(),
                                          AgoraRtcEngine.destroy(),
                                        }
                                      : {
                                          isStart ? null : GetCurrentDevice(),
                                          isStart
                                              ? null
                                              : setState(() {
                                                  String temp =
                                                      generateWordPairs()
                                                          .take(1)
                                                          .toString();
                                                  chanelName = temp.substring(
                                                      0, temp.length - 1);
                                                }),
                                          isStart ? null : selectSocket(),
                                          isStart ? null : initialize(),
                                          setState(() {
                                            isStart = true;
                                          }),
                                        }
                                  : {
                                      sendRmoveData(),
                                      setState(() {
                                        isConected = false;
                                        isStart = false;
                                        isRemoved = false;
                                      }),
                                      disableAll(),
                                      diSelectAll(),
                                    };
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: (widthScreen - 80) / 4,
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        width: 1,
                                        color: isConected
                                            ? Colors.red
                                            : Colors.green)),
                                child: Transform.rotate(
                                  angle: isConected ? 180 * pi / 180 : 0,
                                  child: Icon(
                                    Icons.power_settings_new,
                                    color:
                                        isConected ? Colors.red : Colors.green,
                                    size: 45.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: (widthScreen - 80) / 2.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color(0xFF303030),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: ListView(
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                children: List.generate(panels.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      widget.isAuther
                                          ? Fluttertoast.showToast(
                                              msg:
                                                  "شما دسترسی به این قابلیت ندارید !")
                                          : setState(() {
                                              panels[index][1] =
                                                  !panels[index][1];
                                            });

                                      isStart ? disableAll() : null;
                                      isStart ? sendRmoveData() : null;
                                      isStart
                                          ? setState(() {
                                              isConected = false;
                                            })
                                          : null;

                                      //! clear all tunel for can create new tunel

                                      isStart
                                          ? {
                                              _users.clear(),
                                              AgoraRtcEngine.leaveChannel(),
                                              AgoraRtcEngine.destroy(),
                                            }
                                          : null;
                                      isStart
                                          ? setState(() {
                                              isStart = false;
                                            })
                                          : null;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: panels[index][1]
                                              ? Color(0xFF707070)
                                              : Color(0xFF303030),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 50.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0)),
                                                child: Icon(
                                                  panels[index][3]
                                                      ? Icons.done
                                                      : Icons.close,
                                                  color: panels[index][3]
                                                      ? Colors.green
                                                      : Colors.red,
                                                  size: 35.0,
                                                ),
                                              ),
                                              Text(
                                                panels[index][0],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void GetCurrentDevice() {
    setState(() {
      isRemoved = false;
    });
    CurrentDevice.removeRange(0, CurrentDevice.length);
    for (int i = 0; i < panels.length; i++) {
      if (panels[i][1]) {
        CurrentDevice.add(panels[i][2]);
      }
    }
  }

  void sendRmoveData() {
    setState(() {
      isRemoved = true;
    });

    // for (int i = 0; i < CurrentDevice.length; i++) {
    //   var DESTINATION_ADDRESS = InternetAddress(CurrentDevice[i]);
    //   RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889)
    //       .then((RawDatagramSocket udpSocket) {
    //     udpSocket.broadcastEnabled = true;
    //     List<int> data = utf8.encode("remove");
    //     udpSocket.send(data, DESTINATION_ADDRESS, 8889);
    //   });
    // }

    for (int i = 0; i < panels.length; i++) {
      if (panels[i][3]) {
        var DESTINATION_ADDRESS = InternetAddress(panels[i][2]);
        RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889)
            .then((RawDatagramSocket udpSocket) {
          udpSocket.broadcastEnabled = true;
          List<int> data = utf8.encode("remove");
          udpSocket.send(data, DESTINATION_ADDRESS, 8889);
        });
      }
    }
  }

  String getActivePanel() {
    List<List> activesPanels = [];
    int counter = 0;
    for (int i = 0; i < panels.length; i++) {
      if (panels[i][1]) {
        activesPanels.add([0, 0, 0, 0]);
        activesPanels[counter][0] = panels[i][0];
        activesPanels[counter][1] = panels[i][1];
        activesPanels[counter][2] = panels[i][2];
        activesPanels[counter][3] = panels[i][3];
        counter++;
      }
    }
    String str = "";
    str += DeviceName;
    str += "*";
    str += "true";
    str += "*";
    str += "true";
    str += "/";
    for (int i = 0; i < activesPanels.length; i++) {
      str += activesPanels[i][0].toString();
      str += "*";
      str += activesPanels[i][1].toString();
      str += "*";
      str += activesPanels[i][2].toString();
      str += "*";
      str += activesPanels[i][3].toString();
      str += "/";
    }
    return str;
  }

  void selectSocket() {
    // ! (testChanel-192.168.1.60
    String strData =
        chanelName.toString() + "-" + MyIp + "-" + getActivePanel();
    Future.delayed(Duration(milliseconds: 500), () {
      for (int i = 0; i < CurrentDevice.length; i++) {
        var DESTINATION_ADDRESS = InternetAddress(CurrentDevice[i]);
        RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889)
            .then((RawDatagramSocket udpSocket) {
          udpSocket.broadcastEnabled = true;
          List<int> data = utf8.encode(strData);
          udpSocket.send(data, DESTINATION_ADDRESS, 8889);
        });
      }
    });
  }

  void disableAll() {
    for (int i = 0; i < panels.length; i++) {
      setState(() {
        panels[i][3] = false;
      });
    }
  }

  void diSelectAll() {
    for (int i = 0; i < panels.length; i++) {
      setState(() {
        panels[i][1] = false;
      });
    }
  }

  void changePanels() {
    panels.removeRange(0, panels.length);
    String tempStr = widget.activePanel;
    tempStr = tempStr.trim();
    List temp = tempStr.split("/");
    int end;
    if (temp[temp.length - 1] == "")
      end = temp.length - 1;
    else
      end = temp.length;

    for (int i = 0; i < end; i++) {
      String str = temp[i];
      List temp2 = str.split("*");
      setState(() {
        panels.add(["0", false, "0", false]);
        panels[i][0] = temp2[0].toString();
        panels[i][1] = true;
        panels[i][2] = "255.255.255.255";
        panels[i][3] = true;
      });
    }
  }
}
