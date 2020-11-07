import 'dart:async';

import 'package:camera1_app/screens/home_screen.dart';
import 'package:camera1_app/screens/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera1_app/others/constants.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300.0,
                height: 300.0,
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'C2',
                  style: KSplashScreen,
                ),
              ),
              SizedBox(
                height: 11,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150.0),
                child: Text(
                  'From JJ Lightscout',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontFamily: "BungeeShade"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
