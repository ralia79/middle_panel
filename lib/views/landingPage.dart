import 'package:flutter/material.dart';
import 'package:vikav/component/listLanding.dart';
import 'package:vikav/views/homeScreen.dart';

class LandigScreen extends StatefulWidget {
  const LandigScreen({Key? key}) : super(key: key);

  @override
  State<LandigScreen> createState() => _LandigScreenState();
}

class _LandigScreenState extends State<LandigScreen> {
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
                      Navigator.push(
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
                  Container(
                    width: widthScreen - 80,
                    child: ListScreen(),
                    alignment: Alignment.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
