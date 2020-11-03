import 'package:camera1_app/screens/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/camera1_cubit.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => Camera1Cubit(),
        child: TakePictureScreen(),
      ),
    );
  }
}

// initialRoute: SplashScreen.id,
// routes: {
// SplashScreen.id: (context) => SplashScreen(),
// TakePictureScreen.id: (context) => TakePictureScreen(),
// },
